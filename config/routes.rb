Rails.application.routes.draw do

  #admin
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #admin
  namespace :admin do
    resources :members,only: [:index, :show, :edit, :update, :top]
    resources :products,only: [:index, :show, :new, :create, :edit,:update]
    resources :gernrs,only: [:index, :create, :edit, :update]
    resources :orders,only: [:index, :show, :update]
  end


  #member
  devise_for :members, controllers: {
    sessions:      'mambers/sessions',
    passwords:     'mambers/passwords',
    registrations: 'mambers/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #member
  scope module: :member do
    resources :members, only: [:top, :show, :edit, :update, :quit, :hide]
  resources :destinations, only: [:index, :create, :show, :edit, :update, :destroy]
  resources :products, only: [:index, :show]
  resources :cart_products, only: [:index, :update, :create, :destroy, :all_destroy]
  resources :orders, only: [:new, :confirm, :create, :index, :show, :thanks]
  end
end