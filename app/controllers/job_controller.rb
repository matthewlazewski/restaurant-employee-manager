class JobController < ApplicationController 
    get '/jobs' do 
        @jobs = Job.all 
        erb :'/jobs/index'
    end 
end 