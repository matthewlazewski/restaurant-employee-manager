require 'pry'

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
            binding.pry 
            #flash[:message] = "Request Failed. Please try again."
            erb :'users/signup'
        end 
    end

    get '/logout' do 
        session.clear 
        redirect to '/login'
    end 
    
    get '/login' do 
        erb :'users/login'
    end 

    post '/login' do 
        user = User.find_by_username(params[:user][:username]) #finds the existence of the user 
        if user && user.authenticate(params[:user][:password]) #verifies both inputs were correct
            session[:user_id] = user.id 
            redirect to '/posts'     
        else
            #flash[:message] = "Incorrect username of password. Please try again."
            redirect to '/login'
        end
    end     


end 