require 'pry'

class JobController < ApplicationController 
    get '/jobs' do 
        if !logged_in?
            redirect to '/login'
        end 

        @user = current_user
        @jobs = Job.all 
        erb :'/jobs/index'
    end 

    get '/jobs/new' do 
        if !logged_in? 
            redirect to '/login'
        end 
        @user = current_user
        erb :'jobs/new'
    end

    get '/jobs/:id' do
        @user = current_user 
        @job = Job.find(params[:id])
        erb :'jobs/show'
    end 

    get '/jobs/:id/edit' do 
        @user = current_user
        if @user.admin == true
            @job = Job.find(params[:id])
            erb :'jobs/edit'
        else
            flash[:access] = "You don't have access to edit."
            redirect to '/jobs'
        end 
    end 

    post '/jobs' do 
        @user = current_user
        if @user.admin = true  
            if params["name"].empty?
                flash[:no_content] = "Please fill your post."
                redirect to '/jobs/new'
            end 
            @job = Job.create(params)
        end 

        redirect to '/jobs'
    end

    patch '/jobs/:id' do 
        job = Job.find(params[:id])
        
        if current_user.admin = true 
            job.update(:name => params["name"])
            job.save  
        end
        redirect to "/jobs/#{job.id}"
    end 

    delete '/jobs/:id' do 
        if current_user.admin = true 
            Job.destroy(params[:id])
            redirect to '/jobs'
        end 
    end

end 