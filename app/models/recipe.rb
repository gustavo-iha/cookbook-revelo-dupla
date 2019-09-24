class Recipe < ApplicationRecord
    def cook_time_text_with_minutes
        "#{cook_time} minutos"
    end
end
