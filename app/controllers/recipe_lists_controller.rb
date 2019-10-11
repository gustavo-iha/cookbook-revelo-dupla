class RecipeListsController < ApplicationController
  
  def index
    @recipe_lists = RecipeList.all
  end

  def show
    @recipe_list = RecipeList.find(params[:id])
    @recipes = @recipe_list.recipes
    flash.now[:notice] = "Nenhuma receita encontrada para: #{@recipe_list.name}" unless @recipes.any?
  end
  
  def new
    @recipe_list = RecipeList.new
  end

  def create
    @recipe_list = current_user.recipe_lists.new(params.require('recipe_list').permit(%i[name]) )
    if @recipe_list.save()
      redirect_to @recipe_list
    else
        # do smth else
    end
  end
end