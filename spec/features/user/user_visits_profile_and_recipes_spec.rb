require 'rails_helper'

feature 'User' do
  scenario 'sees only his recipes' do
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    user2 = User.create(email: 'gustavo2@gmail.com', password: '1234567')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                  cuisine: 'Brasileira', difficulty: 'Médio',
                  cook_time: 60,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)
    Recipe.create(title: 'Bolo de chocolate', recipe_type: recipe_type,
                  cuisine: 'Brasileira', difficulty: 'Médio',
                  cook_time: 60,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe o chocolate, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)

    Recipe.create(title: 'Bolo de mandioca', recipe_type: recipe_type,
                  cuisine: 'Brasileira', difficulty: 'Médio',
                  cook_time: 60,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe o chocolate, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user2)

    login_as(user, scope: :user)
    visit root_path
    within '#mine_nav_option' do
      click_on 'Receitas'
    end

    expect(page).to have_content('Minhas receitas')
    expect(page).to have_content('Bolo de cenoura')
    expect(page).to have_content('Bolo de chocolate')
    expect(page).to_not have_content('Bolo de mandioca')
  end

  scenario "can't see his recipes page if not logged in" do
    visit my_recipes_path

    expect(current_path).to eq new_user_session_path
  end

  scenario "if not logged in, can't see my recipes button on root" do
    visit root_path

    expect(page).to_not have_link('Minhas receitas')
  end
end
