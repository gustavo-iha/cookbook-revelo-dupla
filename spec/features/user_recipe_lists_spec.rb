require 'rails_helper'

feature 'User' do
  xscenario 'saves recipe to list' do
    user = User.create!(email: 'gustavo@gmail.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
                  cuisine: 'Brasileira', difficulty: 'Médio',
                  cook_time: 60,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)
    RecipeList.create!(name: 'Receitas fabulosas', user: user)
    
    visit root_path
    click_on 'Bolo de cenoura'
    select 'Receitas fabulosas', from: 'Adicionar a lista'
    click_on 'Adicionar'

    expect(page)
  end

  scenario 'creates new list' do
    user = User.create!(email: 'gustavo@gmail.com', password: '123456')
    
    login_as(user, scope: :user)
    visit root_path
    
    click_on 'Nova lista'
    fill_in 'Nome da lista', with: 'Receitas fabulosas'
    click_on 'Salvar'

    expect(page).to have_content('Receitas fabulosas')
  end
end