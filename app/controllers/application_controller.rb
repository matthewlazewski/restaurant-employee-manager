require './config/environment'
require 'sinatra/base'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, ENV['SESSION_SECRET']
    register Sinatra::Flash 
    #set :show_exception, false 
  end

  not_found do 
    status 404 
    erb :error
  end 

  get "/" do
    erb :welcome
  end

  error ActiveRecord::RecordNotFound do 
    redirect to '/'
  end 

  helpers do
    def logged_in? 
      !!session[:user_id]
    end 

    def current_user 
      @current_user ||= User.find_by_id(session[:user_id])
    end 

  end 

end
