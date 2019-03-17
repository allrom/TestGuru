Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, path: :gurus,
                     path_names: { sign_in: :login, sign_out: :logout },
                     controllers: { sessions: 'sessions' }

  root to: 'tests#index'

  resources :tests, only: :index do

    member do
      post :start
    end
  end

  namespace :admin do
    root to: 'tests#index'

    resources :tests do
      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end
  end

  resources :test_passages, only: %i[show update] do
    member do
      get :result
    end
  end
end
