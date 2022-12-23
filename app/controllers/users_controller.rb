# frozen_string_literal: true

# class for working with users
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  skip_before_action :authenticate, only: %i[new create]
  skip_before_action :authenticate_as_admin, only: %i[new create show add_to_wallet destroy]

  # GET /users or /users.json
  def index
    @users = User.all
    p session[:current_user_id]
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to sessions_new_path }
      else
        format.html { redirect_to new_user_path(errors: @user.errors.full_messages) }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to sessions_new_path }
      else
        format.html { redirect_to new_user_path(errors: @user.errors.full_messages) }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @current_user.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

  def add_to_wallet
    if wallet_params[:money].to_f.positive?
      @current_user.update(money: (wallet_params[:money].to_f + @current_user.money.to_f))
      @current_user.save
    end
    redirect_to user_path(@current_user)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :password, :email, :errors)
  end

  def wallet_params
    params.permit(:money)
  end
end
