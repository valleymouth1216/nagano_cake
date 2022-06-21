Rails.application.routes.draw do

  root to: 'public/homes#top'
  get 'about'=>"public/homes#about"
  
 devise_for :admin,skip: [:passwords],  controllers: {
  sessions: "admin/sessions",
   registrations: "admin/registrations"
 }
 
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  
    namespace :admin do
    resources:genres,only:[:edit,:create,:index,:update]
    resources:items,only:[:new,:index,:create,:show,:edit,:update]
    resources:customers,only:[:index,:show,:edit,:update]
  end

 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
