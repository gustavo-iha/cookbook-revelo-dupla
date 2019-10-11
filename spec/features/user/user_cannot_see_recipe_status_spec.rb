require 'rails_helper'

feature 'User' do

  scenario 'cannot see pending recipes via url' do
    user = User.create(email: 'gustavo@gmail.com', password: '123456')
    login_as(user, scope: :user)

    visit pending_recipes_path

    expect(current_path).to eq root_path
  end
end