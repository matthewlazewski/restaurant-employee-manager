require 'pry'
require 'sinatra/base'
require 'sinatra/flash'

class UserController < ApplicationController 

    get '/users' do
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
            flash[:error] = "Please enter a valid #{label}."
            redirect to '/signup'
          end
        end
        user = User.create(:username => params["username"], :email => params["email"], :password => params["password"],:job_id => params["job_id"]) 
        session[:user_id] = user.id
        redirect to '/users'
    end

    get '/users/:id' do 
        job = Job.find_by_id(params[:id])
        posts = Post.find_by_id(params[:user_id])
        @user = User.find_by_id(params[:id])
        erb :'/users/show'
    end 

    get '/logout' do 
        session.clear 
        redirect to '/'
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
            flash[:message] = "Incorrect username or password. Please try again."
            redirect to '/login'
        end
    end     


end 