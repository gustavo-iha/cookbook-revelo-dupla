class Recipe < ApplicationRecord

    belongs_to :recipe_type

    validates :title, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method, presence: true

    def cook_time_text_with_minutes
        "#{cook_time} minutos"
    end
end
