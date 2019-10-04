require 'rails_helper'

describe 'User can not add recipe' do

  it 'to another user list' do
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)
    recipe_list = RecipeList.create(name: 'Receitas fabulosas da Patrícia', user: user)

    user_2 = User.create(email: 'gustavo_2@gmail.com', password: '123456')

    login_as(user_2, scope: :user)
    post add_to_list_recipe_path(recipe),  params: { recipe_list_id: recipe_list.id}

    expect(response).to redirect_to(root_path)
  end
end