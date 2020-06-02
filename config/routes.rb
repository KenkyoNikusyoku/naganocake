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

end
