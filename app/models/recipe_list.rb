class RecipeList < ApplicationRecord
  belongs_to :user

  has_many :recipe_list_items, dependent: :destroy
  has_many :recipes, through: :recipe_list_items

  def owned?(other_user)
    user == other_user
  end
end
