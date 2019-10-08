require 'rails_helper'

xdescribe 'Recipes API' do
  context 'index' do
    it 'and view multiple recipes' do
      user = User.create!(email: 'gustavo@gmail.com', password: '123456')
      recipe_type = RecipeType.create!(name: 'Sobremesa')
      carrot_cake_recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: 'Brasileira',
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                    user: user, status: :approved)
      chocolate_cake_recipe = Recipe.create!(title: 'Bolo de chocolate', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: 'Brasileira',
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                    user: user, status: :approved)
      pending_recipe = Recipe.create!(title: 'Bolo de banana', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: 'Brasileira',
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                    user: user, status: :approved)
      rejected_recipe = Recipe.create!(title: 'Bolo de rolo', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: 'Brasileira',
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                    user: user, status: :approved)

      get 'api/v1/recipes' 

      json_recipes = JSON.parse(response.body, symbolize_names: true)

      # expect(request.status).to eq 200
      expect(request).to have_http_status(:ok)
      expect(json_recipes[0][:title]).to eq carrot_cake_recipe.title
      expect(json_recipes[1][:title]).to eq chocolate_cake_recipe.title
      expect(response.body).not_to include pending_recipe.title
      expect(response.body).not_to include rejected_recipe.title
    end
  end
end