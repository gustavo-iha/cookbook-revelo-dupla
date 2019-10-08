require 'rails_helper'

describe 'Recipe types API' do
  context 'create' do
    it 'and create a new recipe type' do
      
      post api_v1_recipe_types_path, params: {name: 'entrada'}

      json_recipe_type = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:created)
      expect(json_recipe_type[:name]).to eq 'entrada'
      expect(response.content_type).to eq 'application/json'
    end
  end
end