require 'rails_helper'

feature 'Visitor' do
  scenario 'logs in' do
    User.create!(email: 'stefano@revelo.com.br', password: '12345678')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'stefano@revelo.com.br'
    fill_in 'Senha', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content('Log in efetuado com sucesso')
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Entrar')
    expect(page).not_to have_link('Cadastre-se')
  end

  scenario 'logs in and out' do
    User.create!(email: 'stefano@revelo.com.br', password: '12345678')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'stefano@revelo.com.br'
    fill_in 'Senha', with: '12345678'
    click_on 'Log in'
    click_on 'Sair'

    expect(page).to have_link('Entrar')
    expect(page).to_not have_link('Sair')
    expect(page).to have_link('Cadastre-se')
    expect(page).to have_content('Até a próxima...')
  end

  scenario 'signs up' do
    visit root_path
    click_on 'Cadastre-se'
    fill_in 'Email', with: 'stefano@revelo.com.br'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmar a senha', with: '12345678'
    click_on 'Cadastrar'

    expect(page).to have_content('Você se registrou com sucesso')
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Entrar')
    expect(page).not_to have_link('Cadastre-se')
  end
end
