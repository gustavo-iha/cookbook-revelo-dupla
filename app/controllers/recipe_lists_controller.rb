class RecipeListsController < ApplicationController
  def index
    @recipe_lists = RecipeList.all
  end

  def show
    @recipe_list = RecipeList.find(params[:id])
    @recipes = @recipe_list.recipes
    msg = 'Nenhuma receita encontrada para: '
    flash.now[:notice] = "#{msg}#{@recipe_list.name}" unless @recipes.any?
  end

  def new
    @recipe_list = RecipeList.new
  end

  def create
    parameters = params.require('recipe_list').permit(%i[name])
    @recipe_list = current_user.recipe_lists.new parameters
    redirect_to @recipe_list if @recipe_list.save
  end
end
