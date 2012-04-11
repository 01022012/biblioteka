Library::Application.routes.draw do
  
  resources :categories

  get "passwords/new"

  get "passwords/update"
  resources :passwords
  resources :users
  resource :session
  #resources :books
  match 'sign_out', :to => 'sessions#destroy', :as => "sign_out"
  match 'books_in_category', :to => 'books#by_cat', :as => "books_in_category"

  resources :books do
    collection do
      get :search
    end
    resources :reservations, only: [:create, :new] do
      member do
        put :free
      end
    end
    resources :tags
    resources :comments
  end
  
  resources :tags
  resources :comments, only: [:create, :new]
  
  root :to => 'site#index' #'books#index'
  match '/feed' => 'books#feed', :as => :feed, :defaults => { :format => 'atom' }
end
