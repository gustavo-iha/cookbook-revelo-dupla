class RecipesController < ApplicationController

    before_action :set_recipe, only: %i[edit show update]

    def index
        @recipes = Recipe.all
    end

    def show; end

    def new
        @recipe = Recipe.new()
    end

    def create
        @recipe = Recipe.new(params_to_recipe)
        if @recipe.save()
            redirect_to @recipe
        else
            flash.now[:validation_error] = 'Você deve informar todos os dados da receita'
            render :new
        end
    end

    def edit; end

    def update
        # @recipe.attributes = params_to_recipe
        # @recipe.save()
        @recipe.update(params_to_recipe)
        redirect_to @recipe
    end

    private
    def set_recipe
        @recipe = Recipe.find(params[:id])
    end

    def params_to_recipe
        params.require('recipe').permit(%i[title recipe_type
            cuisine difficulty
            cook_time ingredients
            cook_method])
    end
end