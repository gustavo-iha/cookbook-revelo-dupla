require 'rails_helper'

describe 'User can not edit someone else recipes' do
  it 'throught patch path' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: 'Brasileira',
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços '\
                          'pequenos, misture com o restante dos ingredientes',
                           user: user)

    user2 = User.create(email: 'gustavo_2@gmail.com', password: '123456')

    login_as(user2, scope: :user)
    patch recipe_path(recipe), params: {}

    expect(response).to redirect_to(root_path)
  end
end
