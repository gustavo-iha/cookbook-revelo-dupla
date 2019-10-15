require 'rails_helper'

feature 'User' do
  scenario 'creates new list' do
    user = User.create!(email: 'gustavo@gmail.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path

    click_on 'Lista'
    fill_in 'Nome da lista', with: 'Receitas fabulosas'
    click_on 'Salvar'

    expect(page).to have_content('Receitas fabulosas')
  end

  scenario 'adds recipe to list' do
    user = User.create!(email: 'gustavo@gmail.com', password: '123456')
    user2 = User.create!(email: 'gustavo2@gmail.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
                   cuisine: 'Brasileira', difficulty: 'Médio',
                   cook_time: 60,
                   ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user2,
                   status: :approved)
    RecipeList.create!(name: 'Receitas fabulosas', user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Bolo de cenoura'
    select 'Receitas fabulosas', from: 'Adicionar a lista'
    click_on 'Adicionar'

    expect(page).to have_content('Pertence à(s) lista(s): Receitas fabulosas')
  end

  scenario 'adds recipe to list and only it' do
    user = User.create!(email: 'gustavo@gmail.com', password: '123456')
    user2 = User.create!(email: 'gustavo2@gmail.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    added_recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
                                  cuisine: 'Brasileira', difficulty: 'Médio',
                                  cook_time: 60,
                                  ingredients: 'Farinha, açucar, cenoura',
                                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user2,
                                  status: :approved)
    normal_recipe = Recipe.create!(title: 'Bolo de chocolate', recipe_type: recipe_type,
                                   cuisine: 'Brasileira', difficulty: 'Médio',
                                   cook_time: 60,
                                   ingredients: 'Farinha, açucar, cenoura',
                                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user2,
                                   status: :approved)
    RecipeList.create!(name: 'Receitas fabulosas', user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on added_recipe.title
    select 'Receitas fabulosas', from: 'Adicionar a lista'
    click_on 'Adicionar'

    visit recipe_path(normal_recipe)

    expect(page).not_to have_content('Pertence às listas: Receitas fabulosas')
  end

  scenario 'can not add recipe to another user list' do
    user = User.create!(email: 'gustavo@gmail.com', password: '123456')
    user2 = User.create!(email: 'gustavo2@gmail.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
                   cuisine: 'Brasileira', difficulty: 'Médio',
                   cook_time: 60,
                   ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user2,
                   status: :approved)
    RecipeList.create!(name: 'Receitas fabulosas', user: user)

    login_as(user2, scope: :user)
    visit root_path
    click_on 'Bolo de cenoura'

    expect(page).not_to have_content('Receitas fabulosas')
  end

  scenario 'can not add the same recipe to a recipe_list twice' do
    user = User.create!(email: 'gustavo@gmail.com', password: '123456')
    user2 = User.create!(email: 'gustavo2@gmail.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
                            cuisine: 'Brasileira', difficulty: 'Médio',
                            cook_time: 60,
                            ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user2,
                            status: :approved)
    recipe_list = RecipeList.create!(name: 'Receitas fabulosas', user: user)

    RecipeListItem.create!(recipe: recipe, recipe_list: recipe_list)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Bolo de cenoura'
    select 'Receitas fabulosas', from: 'Adicionar a lista'
    click_on 'Adicionar'

    recipe_list.reload

    expect(page).to have_content('Essa receita já pertence à lista Receitas fabulosas')
    expect(recipe_list.recipes).to include(recipe)
  end
end
