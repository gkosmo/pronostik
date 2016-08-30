module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters , if: :devise_controller?
    def update
      @user = current_user
      @user.update(params_user)
      @user.save!
      redirect_to dashboard_statistics_path
    end


    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [:country])

      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :email, :country, :password, :password_confirmation, :remember_me])
    end


    private

    def params_user
      params.require(:user).permit(:country)

    end
    def update_resource(resource, params)
      resource.update_without_password(params)
    end

  end
end
