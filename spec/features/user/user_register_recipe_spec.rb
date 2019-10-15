require 'rails_helper'

feature 'User register recipe' do
  scenario 'and must be logged in' do
    visit root_path

    expect(page).to_not have_link('Cadastrar Receita')
  end

  scenario 'successfully' do
    # cria os dados necessários, nesse caso não vamos criar dados no banco
    RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    user = User.create(email: 'gustavo@gmail.com', password: '123456')

    # simula a ação do usuário
    login_as(user, scope: :user)
    visit root_path
    click_on 'Receita'

    fill_in 'Título', with: 'Tabule'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Cozinha', with: 'Arabe'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'

    # expectativas
    expect(page).to have_content('Tabule')
    expect(page).to have_content('Entrada')
    expect(page).to have_content('Arabe')
    expect(page).to have_content('Fácil')
    expect(page).to have_content('45 minutos')
    expect(page).to have_content('Ingredientes')
    expect(page).to have_content('Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_content('Como Preparar')
    expect(page).to have_content('Misturar tudo e servir. Adicione limão a gosto.')
    expect(page).to have_content('Receita enviada por gustavo@gmail.com')
    expect(page).to have_content('Receita pendente')
  end

  scenario 'and must fill in all fields' do
    User.create(email: 'gustavo@gmail.com', password: '123456')

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'gustavo@gmail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'

    click_on 'Receita'

    fill_in 'Título', with: ''
    fill_in 'Cozinha', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a receita')
  end
end
