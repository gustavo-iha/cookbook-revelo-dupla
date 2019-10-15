require 'rails_helper'

feature 'Visitor' do
  scenario 'cannot see pending recipes via url' do
    visit pending_recipes_path

    expect(current_path).to eq new_user_session_path
  end
end
