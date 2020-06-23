require 'pry'

class UserController < ApplicationController 

    get '/users/all' do
        @users = User.all 
        erb :'/users/all'
    end

    get '/signup' do 
        @jobs = Job.all 
        erb :'users/signup' 
    end 

    post '/signup' do
        params.each do |label, input|
          if input.empty?
            #flash[:signup_error] = "Please enter a value for #{label}"
            @error
            redirect to '/signup'
          end
        end
    
        user = User.create(:username => params["username"], :email => params["email"], :password => params["password"]).set_default_role 
        session[:user_id] = user.id
    
        redirect to '/posts'
    end

    get '/users/:id' do 
        @post = Post.find_by(params[:user_id])
        @user = User.find_by(params[:id])
        erb :'/posts/show'
    end 

    get '/logout' do 
        session.clear 
        redirect to '/login'
    end 
    
    get '/login' do 
        erb :'users/login'
    end 

    post '/login' do 
        user = User.find_by(:username => params["username"]) #finds the existence of the user 
        if user && user.authenticate(params[:password]) #verifies both inputs were correct
            session[:user_id] = user.id 
            redirect to '/posts'     
        else
            #flash[:message] = "Incorrect username of password. Please try again."
            redirect to '/login'
        end
    end     


end 