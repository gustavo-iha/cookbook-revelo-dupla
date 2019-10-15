class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :recipe_lists, dependent: :destroy

  enum role: { normal: 0, admin: 1 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
