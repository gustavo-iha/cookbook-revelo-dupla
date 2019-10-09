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
                    user: user, status: :pending)
      rejected_recipe = Recipe.create!(title: 'Bolo de rolo', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: 'Brasileira',
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                    user: user, status: :rejected)

      get api_v1_recipes_path

      json_recipes = JSON.parse(response.body, symbolize_names: true)

      # HEADER {Content-Type? 'application/json'}

      # expect(response.status).to eq 200
      expect(response).to have_http_status(:ok)
      expect(json_recipes[0][:title]).to eq carrot_cake_recipe.title
      expect(json_recipes[1][:title]).to eq chocolate_cake_recipe.title
      expect(json_recipes[1][:recipe_type][:name]).to eq chocolate_cake_recipe.recipe_type.name
      expect(response.body).to include (pending_recipe.title)
      expect(response.body).to include (rejected_recipe.title)
      expect(response.content_type).to eq 'application/json'
    end

    it 'and filters recipes by status' do
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
                    user: user, status: :pending)
      rejected_recipe = Recipe.create!(title: 'Bolo de rolo', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: 'Brasileira',
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                    user: user, status: :rejected)

      get api_v1_recipes_path(status: 'approved')

      json_recipes = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json_recipes[0][:title]).to eq carrot_cake_recipe.title
      expect(json_recipes[1][:title]).to eq chocolate_cake_recipe.title
      expect(json_recipes[1][:recipe_type][:name]).to eq chocolate_cake_recipe.recipe_type.name
      expect(response.body).not_to include (pending_recipe.title)
      expect(response.body).not_to include (rejected_recipe.title)
      expect(response.content_type).to eq 'application/json'
    end

    it 'and filters recipes by pending status' do
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
                    user: user, status: :pending)
      rejected_recipe = Recipe.create!(title: 'Bolo de rolo', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: 'Brasileira',
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                    user: user, status: :rejected)

      get api_v1_recipes_path(status: 'pending')

      json_recipes = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json_recipes[0][:title]).to eq pending_recipe.title
      expect(response.body).not_to include (carrot_cake_recipe.title)
      expect(response.body).not_to include (chocolate_cake_recipe.title)
      expect(response.body).not_to include (rejected_recipe.title)
      expect(response.content_type).to eq 'application/json'
    end

    it 'and filters recipes by rejected status' do
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
                    user: user, status: :pending)
      rejected_recipe = Recipe.create!(title: 'Bolo de rolo', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: 'Brasileira',
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                    user: user, status: :rejected)

      get api_v1_recipes_path(status: 'rejected')

      json_recipes = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json_recipes[0][:title]).to eq rejected_recipe.title
      expect(response.body).not_to include (pending_recipe.title)
      expect(response.body).not_to include (chocolate_cake_recipe.title)
      expect(response.body).not_to include (carrot_cake_recipe.title)
      expect(response.content_type).to eq 'application/json'
    end

    it 'and filters recipes by unknown status' do
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
                    user: user, status: :pending)
      rejected_recipe = Recipe.create!(title: 'Bolo de rolo', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: 'Brasileira',
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                    user: user, status: :rejected)

      get api_v1_recipes_path(status: 'bla')

      json_recipes = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:not_found)
      expect(json_recipes).to be_empty
      expect(response.content_type).to eq 'application/json'
    end
  end

  context 'show' do
    it 'and views a single recipe by id' do
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

      get api_v1_recipe_path(carrot_cake_recipe.id)

      json_recipe = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json_recipe[:title]).to eq carrot_cake_recipe.title
      expect(response.body).not_to include (chocolate_cake_recipe.title)
      expect(response.content_type).to eq 'application/json'
    end

    it 'and tries to find an unkown recipe id' do
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

      get api_v1_recipe_path(1000)

      json_recipe = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to eq 'application/json'
    end
  end
end