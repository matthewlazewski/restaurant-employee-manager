require 'pry'

class JobController < ApplicationController 
    get '/jobs' do 
        @user = current_user
        @jobs = Job.all 
        erb :'/jobs/index'
    end 

    get '/jobs/new' do 
        if !logged_in? 
            redirect to '/login'
        end 
        erb :'jobs/new'
    end

    get '/jobs/:id' do 
        @job = Job.find(params[:id])
        erb :'jobs/show'
    end 

    get '/jobs/:id/edit' do 
        user = current_user
        @job = Job.find(params[:id])
        erb :'jobs/show'
    end 

    get '/jobs/:id/edit' do 
        if !logged_in? 
            redirect to '/login'
        end 

        @job = Job.find_by_id(params)

        # if current_user.id != @job.user_id
        #     flash[:message] = "You don't have access to edit this post. " 
        #     redirect to '/jobs'
        # end 
        erb :'/jobs/edit'
    end

    post '/jobs' do 
        user = current_user 
        if params["name"].empty?
            #flash[:no_content] = "Please fill your post."
            redirect to '/jobs/new'
        end 
        @job = Job.create(params)

        redirect to '/jobs'
    end

    patch '/jobs/:id' do 
        job = Job.find(params[:id])
        
        if current_user.id
            job.update(:name => params["name"])
            job.save 
        else 
            #error 
        end
        redirect to "/jobs/#{job.id}"
    end 

    delete '/jobs/:id' do 
        Job.destroy(params[:id])
        redirect to '/jobs'
    end

end 