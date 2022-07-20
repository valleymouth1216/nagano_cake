Rails.application.routes.draw do

    namespace :admin do
    resources:genres,only:[:edit,:create,:index,:update]
    resources:items,only:[:new,:index,:create,:show,:edit,:update]
    resources:customers,only:[:index,:show,:edit,:update]
    resources:orders,only:[:show,:update] do
    resources :order_details, only: [:update]
    end
  end
  get 'admin'=>"admin/homes#top"


   scope module: :public do
    resources :addresses,only:[:edit,:create,:index,:update,:destroy]
    resources :items,only:[:index,:show]
    resources :cart_items,only:[:index,:update,:create,:destroy]
    delete 'cart_items'=>"cart_items#destroy_all"
    post "orders/confirm" => "orders#confirm"
    get "orders/complete" => "orders#complete"
    resources :orders,only:[:index,:new,:create,:show]
  end


 #顧客の会員
 get 'customers/my_page'=>"public/customers#show"
 get 'customers/edit'=>"public/customers#edit"
 patch "customers" => "public/customers#update"
 get 'customers/unsubscribe'=>"public/customers#unsubscribe"
 patch "customers/withdrawal" => "public/customers#withdrawal"

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


 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
