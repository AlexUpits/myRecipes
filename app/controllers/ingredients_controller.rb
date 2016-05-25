class IngredientsController < ApplicationController
    before_action :set_ingredient, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show]
   
    def new
        @ingredient = Ingredient.new
    end 
    
    def show
        @recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 6)
    end
    
    def create
        @ingredient = Ingredient.new(ingredient_params)
        respond_to do |format|
            if @ingredient.save
                format.html { redirect_to ingredient_path(@ingredient), notice: 'ingredient was successfully created.' }
                format.json { render :show, status: :created, location: @ingredient }
            else
                format.html { render :new }
                format.json { render json: @ingredient.errors, status: :unprocessable_entity }
            end
        end
    end
    
    private
        def ingredient_params
            params.require(:ingredient).permit(:name)
        end
        
        def set_ingredient 
            @ingredient = Ingredient.find(params[:id])
        end
end