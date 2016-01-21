class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path
    #redirect_to _path,
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:partner_email, :name]
    devise_parameter_sanitizer.for(:account_update) << [:partner_email, :name]
  end


end
