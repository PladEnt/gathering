class CommentsController < ApplicationController
    get '/comments' do
      if logged_in?
        @comments = Comment.all
        erb :'comments/comments'
      else
        redirect to '/login'
      end
    end
  
    get '/comments/new' do
      if logged_in?
        erb :'comments/create_comment'
      else
        redirect to '/login'
      end
    end
  
    post '/comments' do
      if logged_in?
        if params[:content] == ""
          redirect to "/comments/new"
        else
          @comment = current_user.comments.build(content: params[:content])
          if @comment.save
            redirect to "/comments/#{@comment.id}"
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
        @comment = Comment.find_by_id(params[:id])
        erb :'comments/show_comments'
      else
        redirect to '/login'
      end
    end
  
    get '/comments/:id/edit' do
      if logged_in?
        @comment = Comment.find_by_id(params[:id])
        if @comment && @comment.user == current_user
          erb :'comments/edit_comments'
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
          @comment = Comment.find_by_id(params[:id])
          if @comment && @comment.user == current_user
            if @comment.update(content: params[:content])
              redirect to "/comments/#{@comment.id}"
            else 
              redirect to "/comments/#{@comment.id}/edit"
            end
          else 
            redirect to '/comments'
          end
        end
      else 
        redirect to '/login'
      end
    end
  
    post '/comments/:id/delete' do
      if logged_in?
        @comment = Comment.find_by_id(params[:id])
        if @comment && @comment.user == current_user
          @comment.delete
        end
        redirect to '/comments'
      else
        redirect to '/login'
      end
    end
  end