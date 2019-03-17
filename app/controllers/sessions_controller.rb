class SessionsController < Devise::SessionsController
  before_action :clear_welcome, only: :create

  def clear_welcome
    session[:welcome] = nil
  end
end
