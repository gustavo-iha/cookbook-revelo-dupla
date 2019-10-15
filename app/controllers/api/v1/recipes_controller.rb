# module Api
#   module V1
#     class  RecipesController < ActionController::API
#     end
#   end
# end

class Api::V1::RecipesController < Api::V1::ApiController
  rescue_from ActionController::ParameterMissing, with: :unprocessable_entity
  before_action :permited_status, only: %i[index]

  def index
    render json: Recipe.where(params.permit(:status))
  end

  def show
    @recipe = Recipe.find(params[:id])

    render json: @recipe.as_json, status: :ok
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    render json: {}, status: :ok
  end

  def create
    @recipe = Recipe.create!(recipe_params)
    render json: @recipe, status: :created
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update!(recipe_params)
      render json: @recipe, status: :accepted
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(%i[title recipe_type_id
                                      cuisine difficulty
                                      cook_time ingredients
                                      cook_method user_id])
  end

  def unprocessable_entity
    render json: {}, status: :unprocessable_entity
  end

  def permited_status
    render json: {}, status: :not_found if status?
  end

  def status?
    !Recipe.statuses.include?(params[:status]) && !params[:status].nil?
  end
end
