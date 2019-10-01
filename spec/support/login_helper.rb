module LoginHelper
  def login
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    login_as(user, scope: :user)
    user
  end
end