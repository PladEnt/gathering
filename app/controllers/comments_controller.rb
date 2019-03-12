class CommentsController < ApplicationController
    get '/comments' do
      binding.pry
      if logged_in?
        @comments = comments.all
        erb :'comments/comments'
      else
        redirect to '/login'
      end
    end
  
    get '/comments/new' do
      if logged_in?
        erb :'comments/create_comments'
      else
        redirect to '/login'
      end
    end
  
    post '/comments' do
      if logged_in?
        if params[:content] == ""
          redirect to "/comments/new"
        else
          @comments = current_user.tweets.build(content: params[:content])
          if @comments.save
            redirect to "/comments/#{@comments.id}"
          else 
            redirect to "/comments/new"
          end 
        end
      else 
        redirect to '/login' 
      end
    end
  
    get '/comments/:id' do
      if logged_in?
        @comments = comments.find_by_id(params[:id])
        erb :'comments/show_comments'
      else
        redirect to '/login'
      end
    end
  
    get '/comments/:id/edit' do
      if logged_in?
        @comments = comments.find_by_id(params[:id])
        if @comments && @comments.user == current_user
          erb :'tcommentsweets/edit_comments'
        else
          redirect to '/comments'
        end
      else
        redirect to '/login'
      end
    end
  
    patch '/comment/:id' do
      if logged_in?
        if params[:content] == ""
          redirect to "/comments/#{params[:id]}/edit"
        else
          @comments = comments.find_by_id(params[:id])
          if @comments && @comments.user == current_user
            if @comments.update(content: params[:content])
              redirect to "/comments/#{@comments.id}"
            else 
              redirect to "/comments/#{@comments.id}/edit"
            end
          else 
            redirect to '/comments'
          end
        end
      else 
        redirect to '/login'
      end
    end
  
    delete '/comments/:id/delete' do
      if logged_in?
        @comments = comments.find_by_id(params[:id])
        if @comments && @comments.user == current_user
          @comments.delete
        end
        redirect to '/comments'
      else
        redirect to '/login'
      end
    end
  end