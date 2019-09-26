# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

recipe_type = RecipeType.create(name: 'japonesa')
Recipe.create(title: 'teste', cuisine: 'teste', difficulty: 'teste', cook_time: 10, cook_method: 'assar', ingredients: 'bla', recipe_type: recipe_type)