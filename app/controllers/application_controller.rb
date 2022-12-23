# frozen_string_literal: true

# main functions
class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :current_user
  before_action :errors
  before_action :authenticate
  before_action :authenticate_as_admin
  around_action :switch_locale

  def current_user
    p '/////////////////////////////////'
    @current_user = User.find_by_id(session[:current_user_id])
    if @current_user
      @current_username = @current_user.username
      @current_user_id = @current_user.id
      @current_user_money = @current_user.money
    end
    @current_user
  end

  def errors
    @errors = params[:errors] || []
  end

  def switch_locale(&action)
    locale = locale_from_url || I18n.default_locale
    I18n.with_locale locale, &action
  end

  def locale_from_url
    locale = params[:locale]
    return locale if I18n.available_locales.map(&:to_s).include?(locale)

    nil
  end

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def authenticate
    return if current_user

    redirect_to sessions_new_path
  end

  def authenticate_as_admin
    return if @current_username == 'admin'

    redirect_to sessions_new_path(errors: ['access denied'])
  end
end
