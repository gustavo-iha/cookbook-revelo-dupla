require 'rails_helper'

feature 'Admin' do
  scenario 'sees pending recipes' do
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    admin = User.create(email: 'patriciapoki@gmail.com', password: '123456', role: :admin)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    pending_recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                                   recipe_type: recipe_type, cuisine: 'Brasileira',
                                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                   user: user, status: :pending)

    approved_recipe = Recipe.create(title: 'Bolo de chocolate', difficulty: 'Médio',
                                    recipe_type: recipe_type, cuisine: 'Brasileira',
                                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                    user: user, status: :approved)

    login_as(admin, scope: :user)
    visit root_path

    click_on 'Receitas pendentes'

    expect(page).to have_content(pending_recipe.title)
    expect(page).not_to have_content(approved_recipe.title)
  end

  scenario 'approves pending recipes' do
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    admin = User.create(email: 'patriciapoki@gmail.com', password: '123456', role: :admin)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    pending_recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                                   recipe_type: recipe_type, cuisine: 'Brasileira',
                                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                   user: user, status: :pending)

    another_pending_recipe = Recipe.create(title: 'Bolo de chocolate', difficulty: 'Médio',
                                           recipe_type: recipe_type, cuisine: 'Brasileira',
                                           cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                           user: user, status: :pending)

    login_as(admin, scope: :user)
    visit root_path

    click_on 'Receitas pendentes'

    within "#recipe-#{pending_recipe.id}" do
      click_on 'Aprovar'
    end

    pending_recipe.reload

    expect(page).to have_content(another_pending_recipe.title)
    expect(page).not_to have_content(pending_recipe.title)
    expect(pending_recipe).to be_approved
  end

  scenario 'rejects pending recipe' do
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    admin = User.create(email: 'patriciapoki@gmail.com', password: '123456', role: :admin)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    pending_recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                                   recipe_type: recipe_type, cuisine: 'Brasileira',
                                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                   user: user, status: :pending)

    another_pending_recipe = Recipe.create(title: 'Bolo de chocolate', difficulty: 'Médio',
                                           recipe_type: recipe_type, cuisine: 'Brasileira',
                                           cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                           user: user, status: :pending)

    login_as(admin, scope: :user)
    visit root_path

    click_on 'Receitas pendentes'

    within "#recipe-#{pending_recipe.id}" do
      click_on 'Rejeitar'
    end

    pending_recipe.reload

    expect(page).to have_content(another_pending_recipe.title)
    expect(page).not_to have_content(pending_recipe.title)
    expect(pending_recipe).to be_rejected
  end
end
