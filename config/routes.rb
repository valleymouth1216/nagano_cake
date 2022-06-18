Rails.application.routes.draw do


  

 devise_for :admin,skip: [:passwords],  controllers: {
  sessions: "admin/sessions",
   registrations: "admin/registrations"
 }
  devise_for :customers
  
    namespace :admin do
    resources:genres,only:[:edit,:create,:index,:update]
    resources:items,only:[:new,:index,:create,:show,:edit,:update]
  end

 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
