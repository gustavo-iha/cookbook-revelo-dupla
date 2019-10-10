# module Api
#   module V1
#     class  RecipesController < ActionController::API
#     end
#   end
# end

class Api::V1::RecipesController < Api::V1::ApiController
  rescue_from ActionController::ParameterMissing, with: :unprocessable_entity
  rescue_from ActionController::UnpermittedParameters, with: :forbidden
  before_action :authorize_params, only: %i[update]
  before_action :permited_status, only: %i[index]
  
  # before_action :permited_id, only: %i[show destroy]
  # before_action :permited_content, only: %i[create]

  def index
    # status_search = params[:status]
    # @recipes = []
    # if status_search == 'approved'
    #   @recipes = Recipe.approved
    # elsif status_search == 'pending'
    #   @recipes = Recipe.pending
    # elsif status_search == 'rejected'
    #   @recipes = Recipe.rejected
    # else
    #   @recipes = Recipe.all
    # end

    # @recipes = Recipe.send(permited_status ? params[:status] : 'all')
    # render json: @recipes.as_json, status: :ok

    # return render json: Recipe.all unless permited_status 
    # render json: Recipe.send(params[:status]), status: :ok    
    
    
    # return render json: Recipe.all if params[:status] #-> doesnt need permited_status
    render json: Recipe.where(params.permit(:status)) #-> .permit is enough to guarantee security regarding malicious parameter status injection

    # render json: @recipes.to_json, status: :ok     -> (rails chama as_json no render, que é sobrescrito por to_json)
    # render json: @recipes.to_json(include: { recipe_type: {except: [:id]}}, 
    #   except: [:recipe_type_id]), status: :ok
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
      render json: @recipe, status: :ok
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  private

  def authorize_params
    raise ActionController::UnpermittedParameters.new(status: '') if params.require(:recipe)[:status].present?
  end

  def recipe_params
    params.require(:recipe).permit(%i[title recipe_type_id
                     cuisine difficulty
                     cook_time ingredients
                     cook_method user_id])
  end

  def unprocessable_entity
    render json: {}, status: :unprocessable_entity
  end

  def forbidden
    render json: {}, status: :forbidden
  end

  def permited_status
    render json: {}, status: :not_found if (!Recipe.statuses.include?(params[:status]) && !params[:status].nil?)
  end

  # def permited_content
  #   if params[:title].nil? || params[:recipe_type_id].nil? || params[:cuisine].nil? || params[:difficulty].nil? ||
  #      params[:cook_time].nil? || params[:ingredients].nil? || params[:cook_method].nil? || params[:user_id].nil?
  #     render json: {}, status: :unprocessable_entity 
  #   end
  # end

  # def permited_id
  #   render json: {}, status: :not_found unless Recipe.find_by(id: params[:id])
  # end
end