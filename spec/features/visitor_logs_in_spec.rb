require 'rails_helper'

feature 'Visitor' do
  scenario 'logs in' do
    user = User.create!(email: 'stefano@revelo.com.br', password: '12345678')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'stefano@revelo.com.br'
    fill_in 'Senha', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content('Log in efetuado com sucesso')
    expect(page).to have_link('Log out')
    expect(page).not_to have_link('Entrar')
    expect(page).not_to have_link('Sign up')
  end

  scenario 'logs in and out' do
    user = User.create!(email: 'stefano@revelo.com.br', password: '12345678')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'stefano@revelo.com.br'
    fill_in 'Senha', with: '12345678'
    click_on 'Log in'
    click_on 'Log out'

    expect(page).to have_link('Entrar')
    expect(page).to_not have_link('Log out')
    expect(page).to have_link('Sign up')
    expect(page).to have_content('Até a próxima...')

  end

  scenario 'signs up' do
    visit root_path
    click_on 'Sign up'
    fill_in 'Email', with: 'stefano@revelo.com.br'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmar a senha', with: '12345678'
    click_on 'Cadastrar'

    expect(page).to have_content('Você se registrou com sucesso')
    expect(page).to have_link('Log out')
    expect(page).not_to have_link('Entrar')
    expect(page).not_to have_link('Sign up')
  end
end
