# Application controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:password, :remember_me]
    sign_up_attrs = added_attrs + [:username, :email, :password_confirmation]
    sign_in_attrs = added_attrs + [:username]
    au_attrs = added_attrs + [:email, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: sign_up_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: sign_in_attrs
    devise_parameter_sanitizer.permit :account_update, keys: au_attrs
  end
end
