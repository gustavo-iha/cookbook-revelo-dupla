class Api::V1::RecipeTypesController < ActionController::API
  before_action :permited_status, only: %i[create]
  def create
    @recipe_type = RecipeType.create(recipe_type_params)
    render json: @recipe_type, status: :created
  end

  private

  def recipe_type_params
    params.permit(:name)
  end

  def permited_status
    render json: {}, status: :not_found if params[:name].nil?
  end
end
