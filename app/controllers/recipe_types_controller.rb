class RecipeTypesController < ApplicationController
  before_action :set_recipe_type, only: %i[edit show update]

  def index
    @recipe_types = RecipeType.all
  end

  def show
    @recipe_type = RecipeType.find(params[:id])
    @recipes = @recipe_type.recipes.approved
    msg = 'Nenhuma receita encontrada para: '
    flash.now[:notice] = "#{msg}#{@recipe_type.name}" unless @recipes.any?
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(params_to_recipe_type)
    if @recipe_type.save
      redirect_to recipe_types_path('index')
    else
      flash.now[:validation_error] = 'Tipo de receita é obrigatório'
      render :new
    end
  end

  def edit; end

  def update
    @recipe_type = RecipeType.new(params_to_recipe_type)
    if @recipe_type.update(params_to_recipe_type)
      redirect_to @recipe_type
    else
      flash.now[:validation_error] = 'Tipo de receita é obrigatório'
      render :new
    end
  end

  private

  def set_recipe_type
    @recipe_type = RecipeType.find(params[:id])
  end

  def params_to_recipe_type
    params.require('recipe_type').permit(%i[name])
  end
end
