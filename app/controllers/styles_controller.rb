class StylesController < ApplicationController
    before_action :set_style, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show]
    
    def new
        @style = Style.new
    end 
    
    def show
        @recipes = @style.recipes.paginate(page: params[:page], per_page: 6)
    end
    
    def create
        @style = Style.new(style_params)
        respond_to do |format|
            if @style.save
                format.html { redirect_to style_path(@style), notice: 'style was successfully created.' }
                format.json { render :show, status: :created, location: @style }
            else
                format.html { render :new }
                format.json { render json: @style.errors, status: :unprocessable_entity }
            end
        end
    end
    
    private
        def style_params
            params.require(:style).permit(:name)
        end
        
        def set_style 
            @style = Style.find(params[:id])
        end
end