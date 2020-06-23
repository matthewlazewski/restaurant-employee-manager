class JobController < ApplicationController 
    get '/jobs' do 
        @jobs = Job.all 
        erb :'/jobs/index'
    end 

    get '/jobs/new' do 
        if !logged_in? && current_user.role == "manager" 
            redirect to '/login'
        end 
        erb :'jobs/new'
    end

    post '/jobs' do 
        user = current_user 
        if params["name"].empty?
            #flash[:no_content] = "Please fill your post."
            redirect to '/jobs/new'
        end 
        @job = Job.create(:name => params["name"])

        redirect to '/jobs'
    end
end 