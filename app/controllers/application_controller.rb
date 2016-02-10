class ApplicationController < ActionController::Base
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :show_map, unless: :devise_controller?

  def after_sign_up_path
    #redirect_to _path,
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:partner_email, :name]
    devise_parameter_sanitizer.for(:account_update) << [:partner_email, :name]
  end

  def show_map
    @show_map = true
  end

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = "You need to be a premium user to access that feature"
    redirect_to(request.referrer || root_path)
  end


end
