class UserController < ApplicationController 

    get '/signup' do 
        erb :'users/signup' 
    end 

    post '/signup' do 
        user = User.new(params[:user])
        if user.save 
            session[:user_id] = user.id

            redirect to '/posts'
        else 
            flash[:message] = "Request Failed. Please try again."
            erb :'users/new'
        end 
    end 
end 