class RecipesController < ApplicationController

    before_action :set_recipe, only: %i[edit show update]
    before_action :set_recipe_type_select, only: %i[new edit]

    def index
        @recipes = Recipe.all
    end

    def show; end

    def new
        @recipe = Recipe.new()
    end

    def create
        @recipe = Recipe.new(params_to_recipe_type)
        if @recipe.save()
            redirect_to @recipe
        else
            flash.now[:validation_error] = 'Não foi possível salvar a receita'
            set_recipe_type_select()
            render :new
        end
    end

    def edit; end

    def update
        @recipe = Recipe.new(params_to_recipe_type)
        if @recipe.update(params_to_recipe_type)
            redirect_to @recipe
        else
            flash.now[:validation_error] = 'Não foi possível salvar a receita'
            set_recipe_type_select()
            render :new
        end
    end

    private
    def set_recipe
        @recipe = Recipe.find(params[:id])
    end

    def params_to_recipe_type
        params.require('recipe').permit(%i[title recipe_type_id
            cuisine difficulty
            cook_time ingredients
            cook_method])
    end

    def set_recipe_type_select
        @recipe_types = RecipeType.all
    end
end