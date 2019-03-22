class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

	def default_url_options
		I18n.default_locale == I18n.locale ? {} : { lang: I18n.locale }
	end

  protected

  def configure_permitted_parameters
    attrs = %i[identity_name identity_sname email]
    devise_parameter_sanitizer.permit(:sign_up, keys: attrs)
    devise_parameter_sanitizer.permit(:edit, keys: attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: attrs)
  end

  def after_sign_in_path_for(resource)
    current_user.admin? ? admin_tests_path : tests_path
  end

	def set_locale
		I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
	end
end
