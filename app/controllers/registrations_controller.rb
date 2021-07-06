class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if resource.is_a?(User) && resource.administrator_company?
      new_company_path
    else
      super
    end
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
