class PostController < ApplicationController 
    get '/posts' do 
        @posts = Post.all 
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
        erb :'posts/edit'
    end 

    post '/posts' do 
        user = current_user 
        if params["content"].empty?
            #flash[:no_content] = "Please fill your post."
            redirect to '/posts/new'
        end 
        post = Post.create(:content => params["content"], :user_id => user.id)

        redirect to '/posts'
    end 

    patch '/posts/:id' do 
        post = Post.find(params[:id])
        post.update(:content => params["content"])
        post.save 
        redirect to "/posts/#{post.id}"
    end 


end 