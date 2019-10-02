class RecipeListsController < ApplicationController
  
  def show
    @recipe_list = RecipeList.find(params[:id])
  end
  
  def new
    @recipe_list = RecipeList.new
  end

  def create
    @recipe_list = RecipeList.new(params.require('recipe_list').permit(%i[name]) )
    if @recipe_list.save()
      redirect_to @recipe_list
  else
      # do smth else
  end
  end
end