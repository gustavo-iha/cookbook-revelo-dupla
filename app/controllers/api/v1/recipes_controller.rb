# module Api
#   module V1
#     class  RecipesController < ActionController::API
#     end
#   end
# end

class Api::V1::RecipesController < ActionController::API
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

  private

  def permited_status
    Recipe.statuses.include?(params[:status])
  end
end