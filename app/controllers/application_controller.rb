class ApplicationController < ActionController::Base
  
  
 before_action :authenticate_admin!

  def after_sing_in_path_for(resource)
    admin_genres_path
  end
  
  def after_sign_out_path_for(resource)
      admin_genres_path
  end
end
