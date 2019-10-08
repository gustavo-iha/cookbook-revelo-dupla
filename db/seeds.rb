user = User.create!(email: 'gustavo2@gmail.com', password: '123456')
recipe_type = RecipeType.create!(name: 'Sobremesa')
carrot_cake_recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
              recipe_type: recipe_type, cuisine: 'Brasileira',
              cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
              user: user, status: :approved)
chocolate_cake_recipe = Recipe.create!(title: 'Bolo de chocolate', difficulty: 'Médio',
              recipe_type: recipe_type, cuisine: 'Brasileira',
              cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
              user: user, status: :approved)
pending_recipe = Recipe.create!(title: 'Bolo de banana', difficulty: 'Médio',
              recipe_type: recipe_type, cuisine: 'Brasileira',
              cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
              user: user, status: :pending)
rejected_recipe = Recipe.create!(title: 'Bolo de rolo', difficulty: 'Médio',
              recipe_type: recipe_type, cuisine: 'Brasileira',
              cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
              user: user, status: :rejected)