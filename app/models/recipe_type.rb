class RecipeType < ApplicationRecord
  has_many :recipes, dependent: :destroy

  validates :name, presence: true
  validates(:name,
            uniqueness: { message: 'Receitas duplicadas não são permitidas' })
end
