Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  get 'my-recipes', to: 'users#my_recipes', as: :my_recipes
  get 'search', to: 'recipes#search', as: :search_recipe
  resources :recipes, only: %i[index show new create edit update] do 

    get 'pending', on: :collection

    member do
      post 'add_to_list', to: 'recipes#add_to_list', as: :add_to_list
      patch 'approve'
      patch 'reject'
    end
  end  
  resources :recipe_types, only: %i[index show new create]
  resources :recipe_lists, only: %i[show new create] 
end


