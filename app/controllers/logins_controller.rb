class LoginsController < ApplicationController
    
    def destroy
        session[:chef_id] = nil
        flash.now[:sucess] = "You are logout"
        redirect_to root_path
    end

    def new
        
    end
    
    def create
        chef = Chef.find_by(email: params[:email])
        if chef && chef.authenticate(params[:password].downcase)
            session[:chef_id] = chef.id
            flash.now[:sucess] = "You are login"  
            redirect_to recipes_path
        else
            flash.now[:danger] = "Your email or password does not match"  
            render 'new'
        end
    end
    

end
