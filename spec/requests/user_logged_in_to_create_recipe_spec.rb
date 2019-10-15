require 'rails_helper'

describe 'User must be logged in' do
  # context 'user' do
  # end

  # context 'admin' do
  # end

  it 'to create recipe post to recipe path' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    post recipes_path, params: { recipe: {  title: 'Bolo de cenoura',
                                            recipe_type_id: recipe_type.id,
                                            cuisine: 'Brasileira',
                                            difficulty: 'Médio',
                                            cook_time: 60,
                                            ingredients: 'Farinha, açucar, '\
                                            'cenoura',
                                            cook_method: 'Cozinhe a cenoura, '\
                                            'corte em pedaços pequenos, '\
                                            'misture com o restante dos '\
                                            'ingredientes' } }

    expect(response).to redirect_to(new_user_session_path)
  end

  it 'to edit recipe to recipe path' do
    patch recipe_path(1), params: {}

    expect(response).to redirect_to(new_user_session_path)
  end
end
