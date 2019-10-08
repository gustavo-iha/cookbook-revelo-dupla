# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

RecipeType.create(name: 'Entrada')
recipe_type = RecipeType.create(name: 'Sobremesa')

Recipe.create(title: 'teste', cuisine: 'teste', difficulty: 'teste', cook_time: 10, cook_method: 'assar', ingredients: 'bla', recipe_type: recipe_type)

user = User.create(email: 'test@gmail.com', password: '123456')
User.create(email: 'admin@gmail.com', password: '123456', role: :admin)
  
Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
              recipe_type: recipe_type, cuisine: 'Brasileira',
              cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
              user: user, status: :pending)
  
Recipe.create(title: 'Bolo de chocolate', difficulty: 'Médio',
              recipe_type: recipe_type, cuisine: 'Brasileira',
              cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
              user: user, status: :approved)