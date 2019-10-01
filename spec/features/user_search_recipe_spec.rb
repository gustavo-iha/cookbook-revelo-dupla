require 'rails_helper'

feature 'User search recipe' do
  scenario 'successfully' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco (ARRANGE)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                  cuisine: 'Brasileira', difficulty: 'Médio',
                  cook_time: 60,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)
    Recipe.create(title: 'Bolo de chocolate', recipe_type: recipe_type,
                  cuisine: 'Brasileira', difficulty: 'Médio',
                  cook_time: 61,
                  ingredients: 'Farinha, açucar, chocolate',
                  cook_method: 'Cozinhe o chocolate, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)

    # simula a ação do usuário (ACT)
    login_as(user, scope: :user)
    visit root_path
    fill_in 'Pesquisar receita:', with: 'Bolo de cenoura'
    click_on 'Pesquisar'

    # expectativas do usuário após a ação
    expect(page).to have_content('1 resultado encontrado para: Bolo de cenoura')
    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to_not have_css('h1', text: 'Bolo de chocolate')
  end

  scenario 'and does not find' do
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: 'Brasileira', difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)

    login_as(user, scope: :user)
    visit root_path
    fill_in 'Pesquisar receita:', with: 'Bolo de chocolate'
    click_on 'Pesquisar'

    expect(page).to have_content('Nenhuma receita encontrada para: Bolo de chocolate')
  end

  scenario 'by partial name and finds multiple results' do
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                  cuisine: 'Brasileira', difficulty: 'Médio',
                  cook_time: 60,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)
    Recipe.create(title: 'Bolo de chocolate', recipe_type: recipe_type,
                  cuisine: 'Brasileira', difficulty: 'Médio',
                  cook_time: 61,
                  ingredients: 'Farinha, açucar, chocolate',
                  cook_method: 'Cozinhe o chocolate, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)
    Recipe.create(title: 'Tabule', recipe_type: recipe_type,
                  cuisine: 'Brasileira', difficulty: 'Muito Hard',
                  cook_time: 42,
                  ingredients: 'Umas paradas',
                  cook_method: 'Sei lá', user: user)
    
    login_as(user, scope: :user)
    visit root_path
    fill_in 'Pesquisar receita:', with: 'Bolo'
    click_on 'Pesquisar'


    expect(page).to have_content('2 resultados encontrados para: Bolo')
    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h1', text: 'Bolo de chocolate')
    expect(page).to_not have_css('h1', text: 'Tabule')
  end
end
