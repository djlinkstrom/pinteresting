class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def after_sign_in_path_for(resource)
    locations_path
  end
  def after_sign_out_path_for(resource)
    home_path
  end
  def after_registration_path_for(resource)
    locations_path
  end

  def set_current_user
    User.current = current_user
  end
end
