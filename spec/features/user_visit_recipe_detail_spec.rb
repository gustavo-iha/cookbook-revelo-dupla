require 'rails_helper'

feature 'user' do
  scenario 'can not access pending recipes that is not their via url' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    user2 = User.create(email: 'gustavo2@gmail.com', password: '123456')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user,
                           status: :pending)

    login_as(user2, scope: :user)
    visit recipe_path(recipe)

    expect(current_path).to eq root_path
  end
end