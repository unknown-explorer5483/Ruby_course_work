# frozen_string_literal: true

# class for creating and managing sessions
class SessionsController < ApplicationController
  skip_before_action :authenticate, only: %i[new create]
  skip_before_action :authenticate_as_admin

  def new; end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user.nil?

      redirect_to sessions_new_path(errors: ['Incorrect username or password'])
    else
      sign_in user
      redirect_to :root
    end
  end

  def destroy
    sign_out
    redirect_to :root
  end

  private

  def sign_in(user)
    session[:current_user_id] = user.id
    self.current_user = user
  end

  def sign_out
    session[:current_user_id] = nil
    self.current_user = nil
  end

  attr_writer :current_user
end
