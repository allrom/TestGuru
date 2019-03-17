class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    attrs = [:identity_name, :identity_sname, :email]
    devise_parameter_sanitizer.permit(:sign_up, keys: attrs)
    devise_parameter_sanitizer.permit(:edit, keys: attrs)
  end

  def after_sign_in_path_for(resource)
    if current_user.is_a?(Admin)
      admin_tests_path
    else
      tests_path
    end
  end
end
