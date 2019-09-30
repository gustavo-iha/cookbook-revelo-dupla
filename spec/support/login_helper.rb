module LoginHelper
  def login
    user = User.create(email: 'gustavo@gmail.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Log in'
    user
  end
end