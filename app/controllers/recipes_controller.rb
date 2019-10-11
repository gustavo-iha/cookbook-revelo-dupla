class RecipesController < ApplicationController
    before_action :authenticate_user!, only: %i[new create edit update pending approve reject]
    before_action :set_recipe, only: %i[edit show update destroy]
    before_action :set_recipe_type_select, only: %i[new edit]
    before_action :authorized_edit, only: %i[ edit update destroy]
    before_action :authorized_admin, only: %i[ pending approve reject]

    def index
        @recipes = Recipe.approved
        @recipe_types = RecipeType.all
    end

    def show
        @recipe_lists = @recipe.recipe_lists
        @recipe_lists_select = current_user.recipe_lists unless current_user.nil?
        redirect_to root_path if !@recipe.approved? && !@recipe.owned?(current_user)
    end

    def add_to_list
        recipe_list = RecipeList.find(params[:recipe_list_id])

        if recipe_list.owned? current_user
            if recipe_list.recipes.find_by(params[:id])
                flash[:notice] = "Essa receita já pertence à lista #{recipe_list.name}"
            else
                recipe_list.recipes << Recipe.find(params[:id])
            end
            return redirect_to recipe_path(params[:id])
        end
        redirect_to root_path
    end

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

    def destroy
        @recipe.destroy
        redirect_to my_recipes_path
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
        @recipes = Recipe.approved.where('title LIKE ?', "%#{params[:query]}%")
        flash[:notice] = "Nenhuma receita encontrada para: #{params[:query]}" unless @recipes.any?
    end
    
    def pending
        @recipes = Recipe.pending
    end

    def approve
        Recipe.find(params[:id]).approved!
        redirect_to pending_recipes_path
    end

    def reject
        Recipe.find(params[:id]).rejected!
        redirect_to pending_recipes_path
    end

    private

    def set_recipe
        @recipe = Recipe.find(params[:id])
    end

    def params_to_recipe_type
        params.require('recipe').permit(%i[title recipe_type_id
                                          cuisine difficulty
                                          cook_time ingredients
                                          cook_method photo])
    end

    def set_recipe_type_select
        @recipe_types = RecipeType.all
    end

    def authorized_edit
        redirect_to root_path unless @recipe.owned?(current_user)
    end

    def authorized_admin
        redirect_to root_path unless current_user.admin?
    end
end