require 'rails_helper'

feature 'Visitor view recipe details' do
  scenario 'successfully' do
    # cria os dados necessários
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user,
                           status: :approved)

    # simula a ação do usuário
    visit root_path
    click_on recipe.title

    # expectativas do usuário após a ação
    expect(page).to have_content(recipe.title)
    expect(page).to have_content(recipe.recipe_type.name)
    expect(page).to have_content(recipe.cuisine)
    expect(page).to have_content(recipe.difficulty)
    expect(page).to have_content("#{recipe.cook_time} minutos")
    expect(page).to have_content('Ingredientes')
    expect(page).to have_content(recipe.ingredients)
    expect(page).to have_content('Como Preparar')
    expect(page).to have_content(recipe.cook_method)
  end

  scenario 'and return to recipe list' do
    # cria os dados necessários
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user,
                           status: :approved)

    # simula a ação do usuário
    login_as(user, scope: :user)
    visit root_path
    click_on recipe.title
    click_on 'Voltar'

    # expectativa da rota atual
    expect(current_path).to eq(root_path)
  end

  scenario 'can not see the recipe_list form' do
    # cria os dados necessários
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user,
                           status: :approved)

    # simula a ação do usuário
    visit root_path
    click_on recipe.title

    expect(page).not_to have_content('Adicionar a lista')
  end

  scenario 'can not access pending recipes via url' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user,
                           status: :pending)

    visit recipe_path(recipe)

    expect(current_path).to eq root_path
  end
end
