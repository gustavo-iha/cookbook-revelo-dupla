class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[my_recipes]

    def my_recipes
      @recipes = current_user.recipes
    end
end