require 'rails_helper'

feature 'User tries to delete a recipe' do
  scenario 'successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: :approved)

    # simula a ação do usuário
    login_as(user, scope: :user)
    visit root_path
    within '#mine_nav_option' do
      click_on 'Receitas'
    end

    click_on 'Bolo de cenoura'

    click_on 'Deletar'

    expect(current_path).to eq my_recipes_path
    expect(page).not_to have_content('Bolo de cenoura')
  end
end