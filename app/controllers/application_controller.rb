class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :telephone, :postal_code, :address])
	end

  def after_sign_in_path_for(resource)
    case resource
    when Member
      root_path
    when Admin
      top_admin_members_path
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :member
      root_path
    when :admin
      new_admin_session_path
    end
  end
end