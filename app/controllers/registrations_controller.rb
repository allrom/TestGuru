class RegistrationsController < Devise::RegistrationsController

  def after_update_path_for(resource)
    current_user.admin? ? admin_tests_path : tests_path
  end
end
