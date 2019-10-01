class RecipesController < ApplicationController
    before_action :authenticate_user!, only: %i[new create edit update]
    before_action :set_recipe, only: %i[edit show update]
    before_action :set_recipe_type_select, only: %i[new edit]
    before_action :authorized_edit, only: %i[ edit update ]

    def index
        @recipes = Recipe.all
        @recipe_types = RecipeType.all
    end

    def show; end

    def new
        @recipe = Recipe.new()
    end

    def create
        @recipe = current_user.recipes.new(params_to_recipe_type)
        if @recipe.save()
            redirect_to @recipe
        else
            flash.now[:validation_error] = 'Não foi possível salvar a receita'
            set_recipe_type_select()
            render :new
        end
    end

    def edit
    end

    def update
        if @recipe.update(params_to_recipe_type)
            redirect_to @recipe
        else
            flash.now[:validation_error] = 'Não foi possível salvar a receita'
            set_recipe_type_select()
            render :new
        end
    end

    def search
        @recipes = Recipe.where('title LIKE ?', "%#{params[:query]}%")
        flash[:notice] = "Nenhuma receita encontrada para: #{params[:query]}" unless @recipes.any?
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

    def authorized_edit
        redirect_to root_path unless @recipe.owned?(current_user)
    end
end