class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!
  before_action :check_role!

  private

  def check_role!
    redirect_to root_path, alert: "Not Authorized !" unless current_user.is_a?(Admin)
  end
end
