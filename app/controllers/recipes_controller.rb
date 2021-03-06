class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :like]
  before_action :require_user, except: [:show, :index, :like]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_user_like, only: [:like]
  before_action :admin_user, only: :destroy
   
  def index
    #@recipes = Recipe.all.sort_by{ |likes| likes.thumbs_up_total }.reverse
    @recipes = Recipe.paginate(page: params[:page], per_page: 6)
  end
  
  def show
  
  end
  
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_path, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
 
  def new
    @recipe = Recipe.new
  end
 
  def create 
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user
    
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update 
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def like
    Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    redirect_to :back
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids: [], ingredient_ids: [])
    end
    
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
    
    def require_same_user
      if @recipe.chef != current_user && !current_user.admin?
        redirect_to recipes_path, notice: 'You can only edit your own recipes.' 
      end
    end
    
    def require_user_like
      if !logged_in?
        redirect_to :back, notice: 'Recipe was successfully updated.' 
      end  
    end
    
    def admin_user
      redirect_to recipes_path unless current_user.admin? 
    end
end