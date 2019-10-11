require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h2', text: 'Todas as Receitas:')
  end

  scenario 'and view recipe' do
    #cria os dados necessários
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                          recipe_type: recipe_type, cuisine: 'Brasileira',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                          user: user,
                          status: :approved)
    
    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_content(recipe.title)
    expect(page).to have_content(recipe.recipe_type.name)
    expect(page).to have_content(recipe.cuisine)
  end

  scenario 'and view recipes list' do
    #cria os dados necessários
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    another_recipe_type = RecipeType.create(name: 'Prato principal')
    approved_recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                          recipe_type: recipe_type, cuisine: 'Brasileira',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', 
                          user: user,
                          status: :approved)
    
    another_approved_recipe = Recipe.create(title: 'Feijoada',
                              recipe_type: another_recipe_type,
                              cuisine: 'Brasileira', difficulty: 'Difícil',
                              cook_time: 90,
                              ingredients: 'Feijão e carnes',
                              cook_method: 'Misture o feijão com as carnes', 
                              user: user,
                              status: :approved)

    pending_recipe = Recipe.create(title: 'Baião de 2',
                          recipe_type: another_recipe_type,
                          cuisine: 'Brasileira', difficulty: 'Difícil',
                          cook_time: 90,
                          ingredients: 'Feijão e carnes',
                          cook_method: 'Misture o feijão com as carnes', 
                          user: user,
                          status: :pending)

    rejected_recipe = Recipe.create(title: 'Baião de 2',
                          recipe_type: another_recipe_type,
                          cuisine: 'Brasileira', difficulty: 'Difícil',
                          cook_time: 90,
                          ingredients: 'Feijão e carnes',
                          cook_method: 'Misture o feijão com as carnes', 
                          user: user,
                          status: :rejected)
    
    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_content(approved_recipe.title)
    expect(page).to have_content(approved_recipe.recipe_type.name)
    expect(page).to have_content(approved_recipe.cuisine)

    expect(page).to have_content(another_approved_recipe.title)
    expect(page).to have_content(another_approved_recipe.recipe_type.name)
    expect(page).to have_content(another_approved_recipe.cuisine)


    expect(page).not_to have_content(pending_recipe.title)
    expect(page).not_to have_content(rejected_recipe.title)
  end

  scenario 'and cannot see pending recipe list' do
    #cria os dados necessários
        
    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).not_to have_link('Receitas pendentes')
  end
end
