class Recipe < ApplicationRecord

    belongs_to :recipe_type
    belongs_to :user
    has_many :recipe_list_items
    has_many :recipe_lists, through: :recipe_list_items

    enum status: { pending: 0, approved: 1, rejected: 2}

    validates :title, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method, presence: true

    def cook_time_text_with_minutes
        "#{cook_time} minutos"
    end

    def owned?(other_user)
        user == other_user
    end
end
