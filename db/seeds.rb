# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user = User.create(email: 'user@gmail.com', password: '123456')
another_user = User.create(email: 'user2@gmail.com', password: '123456')
User.create(email: 'admin@gmail.com', password: '123456', role: :admin)


main_recipe_type = RecipeType.create!(name: 'Prato principal')
entry_recipe_type = RecipeType.create(name: 'Entrada')
dessert_recipe_type = RecipeType.create!(name: 'Sobremesa')


pate_recipe = Recipe.create!(title: 'Patê de cenoura', difficulty: 'Médio',
              recipe_type: entry_recipe_type, cuisine: 'Brasileira',
              cook_time: 10, ingredients: 'cenoura',
              cook_method: 'martele a cenoura',
              user: user, status: :approved)
pate_recipe.photo.attach(io: File.open("#{Rails.root}/spec/support/images/pate-cenoura.jpg"), filename: "pate-cenoura.jpg")

grass_recipe = Recipe.create!(title: 'Mato', difficulty: 'Médio',
              recipe_type: entry_recipe_type, cuisine: 'Brasileira',
              cook_time: 0, ingredients: 'mato',
              cook_method: 'já está pronto',
              user: another_user, status: :pending)
grass_recipe.photo.attach(io: File.open("#{Rails.root}/spec/support/images/mato.jpg"), filename: "mato.jpg")

salad_recipe = Recipe.create!(title: 'Salada grega', difficulty: 'Médio',
              recipe_type: entry_recipe_type, cuisine: 'Grega',
              cook_time: 5, ingredients: 'tomate, pepino, queijo coalho',
              cook_method: 'já está pronto',
              user: user, status: :pending)
salad_recipe.photo.attach(io: File.open("#{Rails.root}/spec/support/images/salada-grega.jpg"), filename: "salada-grega.jpg")


              
strogonoff_recipe = Recipe.create!(title: 'Strogonoff', difficulty: 'Médio',
              recipe_type: entry_recipe_type, cuisine: 'Italiana',
              cook_time: 40, ingredients: 'strogonoff cru, arroz e batata palha',
              cook_method: 'só cozinhar',
              user: another_user, status: :approved)
strogonoff_recipe.photo.attach(io: File.open("#{Rails.root}/spec/support/images/strogonoff.jpg"), filename: "strogonoff.jpg")

yakisoba_recipe = Recipe.create!(title: 'Yakisoba', difficulty: 'Médio',
              recipe_type: entry_recipe_type, cuisine: 'Chinesa',
              cook_time: 30, ingredients: 'soba',
              cook_method: 'frite o soba',
              user: user, status: :pending)
yakisoba_recipe.photo.attach(io: File.open("#{Rails.root}/spec/support/images/yakisoba.jpg"), filename: "yakisoba.jpg")

beans_rice_recipe = Recipe.create!(title: 'Arroz e feijão', difficulty: 'Médio',
              recipe_type: entry_recipe_type, cuisine: 'Brasileira',
              cook_time: 50, ingredients: 'arroz e feijão cru',
              cook_method: 'cozinhe ambos',
              user: user, status: :pending)
beans_rice_recipe.photo.attach(io: File.open("#{Rails.root}/spec/support/images/arroz-feijao.jpeg"), filename: "arroz-feijao.jpg")



carrot_cake_recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
              recipe_type: dessert_recipe_type, cuisine: 'Brasileira',
              cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
              user: user, status: :approved)
carrot_cake_recipe.photo.attach(io: File.open("#{Rails.root}/spec/support/images/bolo-cenoura.jpg"), filename: "bolo-cenoura.jpg")
      
chocolate_cake_recipe = Recipe.create!(title: 'Bolo de chocolate', difficulty: 'Médio',
              recipe_type: dessert_recipe_type, cuisine: 'Alemã',
              cook_time: 50, ingredients: 'Farinha, açucar, chocolate',
              cook_method: 'Cozinhe o chocolate, corte em pedaços pequenos, misture com o restante dos ingredientes',
              user: another_user, status: :rejected)
chocolate_cake_recipe.photo.attach(io: File.open("#{Rails.root}/spec/support/images/bolo-chocolate.jpg"), filename: "bolo-chocolate.jpg")
 
banana_cake_recipe = Recipe.create!(title: 'Bolo de banana', difficulty: 'Médio',
              recipe_type: dessert_recipe_type, cuisine: 'Brasileira',
              cook_time: 50, ingredients: 'Farinha, açucar, banana',
              cook_method: 'Cozinhe a banana, corte em pedaços pequenos, misture com o restante dos ingredientes',
              user: user, status: :pending)
banana_cake_recipe.photo.attach(io: File.open("#{Rails.root}/spec/support/images/bolo-banana.jpg"), filename: "bolo-banana.jpg")
              