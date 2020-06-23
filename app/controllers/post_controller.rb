require 'pry'
class PostController < ApplicationController 
    get '/posts' do 
        @posts = Post.all 
        @user = current_user 
        erb :'posts/index'
    end 

    get '/posts/new' do 
        if !logged_in? 
            redirect to '/login'
        end 
        erb :'posts/new'
    end
    
    get '/posts/:id' do 
        @post = Post.find(params[:id])
        erb :'posts/show'
    end 

    get '/posts/:id/edit' do 
        if !logged_in? 
            redirect to '/login'
        end 

        @post = Post.find(params[:id])

        if current_user.id != @post.user_id
            flash[:message] = "You don't have access to edit this post. " 
            redirect to '/posts'
        end 
        erb :'/posts/edit'
    end 

    post '/posts' do 
        user = current_user 
        if params["content"].empty?
            #flash[:no_content] = "Please fill your post."
            redirect to '/posts/new'
        end 
        @post = Post.create(:content => params["content"], :user_id => user.id)

        redirect to '/posts'
    end 

    patch '/posts/:id' do 
        post = Post.find(params[:id])
        
        if current_user.id == post.user_id 
            post.update(:content => params["content"])
            post.save 
        else 
            #error 
        end
        redirect to "/posts/#{post.id}"
    end 

    delete '/posts/:id' do 
        Post.destroy(params[:id])
        redirect to '/posts'
    end 


end 