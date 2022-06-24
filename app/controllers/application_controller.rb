class ApplicationController < ActionController::Base


  def after_sign_in_path_for(resource)
    case resource
    when Admin
      about_path
    when Customer
      about_path
    end

  end


  def after_sign_out_path_for(resource)
      root_path
  end

  protected

  def devise_parameter_sanitizer
    if resource_class == Customer
      Public::CustomerParameterSanitizer.new(Customer, :customer, params)
    else
      super # Use the default one
    end
  end

end
