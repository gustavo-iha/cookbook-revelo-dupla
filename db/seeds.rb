# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user = User.create(email: 'user@gmail.com', password: '123456')
User.create(email: 'admin@gmail.com', password: '123456', role: :admin)


entry_recipe_type = RecipeType.create(name: 'Entrada')
dessert_recipe_type = RecipeType.create!(name: 'Sobremesa')

Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
              recipe_type: recipe_type, cuisine: 'Brasileira',
              cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
              user: user, status: :approved)
Recipe.create!(title: 'Bolo de chocolate', difficulty: 'Médio',
              recipe_type: recipe_type, cuisine: 'Brasileira',
              cook_time: 50, ingredients: 'Farinha, açucar, chocolate',
              cook_method: 'Cozinhe o chocolate, corte em pedaços pequenos, misture com o restante dos ingredientes',
              user: user, status: :approved)
Recipe.create!(title: 'Bolo de banana', difficulty: 'Médio',
              recipe_type: recipe_type, cuisine: 'Brasileira',
              cook_time: 50, ingredients: 'Farinha, açucar, banana',
              cook_method: 'Cozinhe a banana, corte em pedaços pequenos, misture com o restante dos ingredientes',
              user: user, status: :pending)
Recipe.create!(title: 'Salada', difficulty: 'Médio',
              recipe_type: entry_recipe_type, cuisine: 'Brasileira',
              cook_time: 0, ingredients: 'mato',
              cook_method: 'já está pronto',
              user: user, status: :rejected)
