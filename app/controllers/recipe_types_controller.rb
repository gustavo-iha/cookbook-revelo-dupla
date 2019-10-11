class RecipeTypesController < ApplicationController

    before_action :set_recipe_type, only: %i[edit show update]

    def index
        @recipe_types = RecipeType.all
    end

    def show
        @recipe_type = RecipeType.find(params[:id])
        @recipes = @recipe_type.recipes.approved
        flash[:notice] = "Nenhuma receita encontrada para: #{@recipe_type.name}" unless @recipes.any?
    end

    def new
        @recipe_type = RecipeType.new()
    end

    def create
        # if RecipeType.where(params_to_recipe_type).any?
        #     flash.now[:validation_error] = 'Receitas duplicadas não são permitidas'
        #     return render :new
        # end

        @recipe_type = RecipeType.new(params_to_recipe_type)
        if @recipe_type.save()
            redirect_to recipe_types_path('index')
        else
            flash.now[:validation_error] = 'Tipo de receita é obrigatório'
            render :new
        end
    end

    def edit; end

    def update
        # @recipe_type.attributes = params_to_recipe_type
        # @recipe_type.save()
        
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