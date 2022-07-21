class ApplicationController < ActionController::Base


  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when Customer
      root_path
    end

  end




  def after_sign_out_path_for(resource)
    case resource
    when :admin   # ログアウト時はシンボルが返ってくる
      new_admin_session_path
    when :customer  # ログアウト時はシンボルが返ってくる
      root_path
    end
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
