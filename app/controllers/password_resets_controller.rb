# frozen_string_literal: true

# class for resetting password
class PasswordResetsController < ApplicationController
  skip_before_action :authenticate
  skip_before_action :authenticate_as_admin

  def new; end

  def edit
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to sessions_new_path, errors: [t(:token_expired).to_s]
  end

  def update
    @user = User.find_signed!(params[:token], purpose: 'password_reset')

    if @user.update(password: password_params[:password])
      redirect_to root_path, notice: 'Your password was reset successfully. Please sign in'
    else
      render :edit
    end
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.present?
      PasswordMailer.with(user: @user).reset.deliver_later
      redirect_to root_path, notice: 'Please check your email to reset the password'
    else
      redirect_to root_path, notice: 'No email'
    end
  end

  private

  def password_params
    params.require(:user).permit(:password)
  end
end
