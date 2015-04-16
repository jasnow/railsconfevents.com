Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "callbacks" }

  devise_scope :user do
    delete "/users/sign_out" => "devise/sessions#destroy"
  end

  root "events#index"

  resources :events, only: [:create, :destroy, :edit, :index, :new, :update] do
    member do
      post :list
    end
  end

  resources :users, only: [:index] do
    member do
      post "promote/:role", action: :promote, as: :promote
    end
  end
end
