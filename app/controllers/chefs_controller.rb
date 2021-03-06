class ChefsController < ApplicationController
    before_action :set_chef, only: [:show, :edit, :update, :destroy]
    before_action :require_same_user, only: [:edit, :update] 

    def index 
        @chefs = Chef.paginate(page: params[:page], per_page: 5)    
    end 
    
    def new
        @chef = Chef.new
    end
    
    def create
        @chef =Chef.new(chef_params)
        respond_to do |format|
            if @chef.save
                session[:chef_id] = @chef.id
                format.html { redirect_to recipes_path, notice: 'chef was successfully created.' }
                format.json { render :show, status: :created, location: @chef }
            else
                format.html { render :new }
                format.json { render json: @chef.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def update 
        respond_to do |format|
            if @chef.update(chef_params)
                format.html { redirect_to  chef_path(@chef), notice: 'Recipe was successfully updated.' }
                format.json { render :show, status: :ok, location: @chef }
            else
                format.html { render :edit }
                format.json { render json: @chef.errors, status: :unprocessable_entity }
            end
        end
    end
    
    private
        def chef_params
            params.require(:chef).permit(:chefName, :email, :password)
        end
        
        def set_chef 
            @chef = Chef.find(params[:id])
            @recipes = @chef.recipes.paginate(page: params[:page], per_page: 6)
        end
        
        def require_same_user
            if @chef != current_user
                redirect_to root_path, notice: 'Recipe was successfully updated.' 
            end
        end
end
