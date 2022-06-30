Rails.application.routes.draw do




 #配送先
   scope module: :public do
    resources :addresses,only:[:edit,:create,:index,:update,:destroy]
    resources :items,only:[:index,:show]
    resources :cart_items,only:[:index,:update,:create,:destroy]
    delete 'cart_items'=>"cart_items#destroy_all"
    resources :orders,only:[:index,:new,:create,:show]
    post "orders/confirm" => "orders#confirm"
    get "orders/complete" => "orders#complete"
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

    namespace :admin do
    resources:genres,only:[:edit,:create,:index,:update]
    resources:items,only:[:new,:index,:create,:show,:edit,:update]
    resources:customers,only:[:index,:show,:edit,:update]
  end

 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
