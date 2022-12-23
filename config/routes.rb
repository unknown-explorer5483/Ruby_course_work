Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
  

    root "hotels#index"
    get 'sessions/new'
    get 'sessions/create'
    get 'sessions/destroy'
    get 'users/index'
    get 'users/new'
    post 'users/add_to_wallet'
    post 'rooms/book'
    get 'rooms/unbook'
    resources :users
    resources :rooms
    resources :hotels

    get 'password/reset', to: 'password_resets#new'
    post 'password/reset', to: 'password_resets#create'
    get 'password/reset/edit', to: 'password_resets#edit'
    patch 'password/reset/edit', to: 'password_resets#update'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

end
