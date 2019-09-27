Rails.application.routes.draw do
  root to: 'recipes#index'
  get 'search', to: 'recipes#search', as: :search_recipe
  resources :recipes, only: %i[index show new create edit update]
  resources :recipe_types, only: %i[index show new create]
end
