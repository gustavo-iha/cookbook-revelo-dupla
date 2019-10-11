require 'rails_helper'

feature 'User visits recipe type' do
  scenario 'and sees recipes' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco (ARRANGE)
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    another_recipe_type = RecipeType.create(name: 'Café da Manhã')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                  cuisine: 'Brasileira', difficulty: 'Médio',
                  cook_time: 60,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user,
                  status: :approved)
    Recipe.create(title: 'Bolo de chocolate', recipe_type: recipe_type,
                  cuisine: 'Brasileira', difficulty: 'Médio',
                  cook_time: 61,
                  ingredients: 'Farinha, açucar, chocolate',
                  cook_method: 'Cozinhe o chocolate, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user,
                  status: :approved)
    Recipe.create(title: 'Bolo de rolo', recipe_type: recipe_type,
                  cuisine: 'Brasileira', difficulty: 'Médio',
                  cook_time: 61,
                  ingredients: 'Farinha, açucar, chocolate',
                  cook_method: 'Cozinhe o chocolate, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user,
                  status: :pending)
    Recipe.create(title: 'Bolo de limão', recipe_type: recipe_type,
                  cuisine: 'Brasileira', difficulty: 'Médio',
                  cook_time: 61,
                  ingredients: 'Farinha, açucar, chocolate',
                  cook_method: 'Cozinhe o chocolate, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user,
                  status: :rejected)
    Recipe.create(title: 'Tabule', recipe_type: another_recipe_type,
                  cuisine: 'Brasileira', difficulty: 'Muito Hard',
                  cook_time: 42,
                  ingredients: 'Umas paradas',
                  cook_method: 'Sei lá', user: user,
                  status: :approved)
    
    # simula a ação do usuário (ACT)
    login_as(user, scope: :user)
    visit root_path
    click_on 'Sobremesa'

    # expectativas do usuário após a ação
    expect(page).to have_content('Bolo de cenoura')
    expect(page).to have_content('Bolo de chocolate')
    expect(page).to_not have_content('Bolo de rolo')
    expect(page).to_not have_content('Bolo de limão')
    expect(page).to_not have_content('Tabule')
  end

  scenario 'and sees that there are no recipes' do
    RecipeType.create(name: 'Sobremesa')

    visit root_path
    click_on 'Sobremesa'

    expect(page).to have_content('Nenhuma receita encontrada para: Sobremesa')
  end
end