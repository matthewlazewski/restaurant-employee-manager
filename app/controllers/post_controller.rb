class PostController < ApplicationController 
    get '/posts' do 
        erb :'posts/index'
    end 
end 