class ApplicationController < ActionController::Base
  skip_forgery_protection

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :private])

    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :private])
  end

  def after_sign_out_path_for(resource_or_scope)
    flash[:notice] = "Signed out successfully."
    new_user_session_path 
  end

  def after_sign_in_path_for(resource_or_scope)
    root_path 
  end
end
