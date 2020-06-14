Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'
  root 'member/members#top'

  get 'home/invalid' => 'home#invalid'

  resources :password_resets,     only: [:new, :create, :edit, :update]

  #admin
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #admin
  namespace :admin do
    resources :members,only: [:index, :show, :edit, :update] do
      collection do
        get :top
      end
    end
    resources :products,only: [:index, :show, :new, :create, :edit,:update]
    resources :genres,only: [:index, :create, :edit, :update]
    resources :orders,only: [:index, :show, :update] do
      member do
        patch :order_update
      end
    end
  end

  patch '/admin/orders/:order_product_id', to: 'admin/orders#work_update'

  #member
  devise_for :members, controllers: {
    sessions:      'members/sessions',
    passwords:     'members/passwords',
    registrations: 'members/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #member
  scope module: :member do
    resources :members, only: [:show, :edit, :update] do
      member do
        get :quit
        delete :hide
      end
      collection do
        get :top
      end
    end
    resources :destinations, only: [:index, :create, :edit, :update, :destroy]
    resources :products, only: [:index, :show] do
      collection do
        post :search
      end
    end
    resources :cart_products, only: [:index, :update, :create, :destroy] do
      collection do
        delete :all_destroy
      end
    end
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        get :confirm
        get :thanks
      end
    end
  end
end