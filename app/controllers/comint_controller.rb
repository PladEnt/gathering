class ComintsController < ApplicationController
    get '/comints' do
      if logged_in?
        @comints = Comints.all
        erb :'comints/comints'
      else
        redirect to '/login'
      end
    end
  
    get '/comints/new' do
      if logged_in?
        erb :'comints/create_comints'
      else
        redirect to '/login'
      end
    end
  
    post '/comints' do
      if logged_in?
        if params[:content] == ""
          redirect to "/comints/new"
        else
          @comints = current_user.tweets.build(content: params[:content])
          if @comints.save
            redirect to "/comints/#{@comints.id}"
          else 
            redirect to "/comints/new"
          end 
        end
      else 
        redirect to '/login' 
      end
    end
  
    get '/comints/:id' do
      if logged_in?
        @comints = Comints.find_by_id(params[:id])
        erb :'comints/show_comints'
      else
        redirect to '/login'
      end
    end
  
    get '/comints/:id/edit' do
      if logged_in?
        @comints = Comints.find_by_id(params[:id])
        if @comints && @comints.user == current_user
          erb :'tcomintsweets/edit_comints'
        else
          redirect to '/comints'
        end
      else
        redirect to '/login'
      end
    end
  
    patch '/comint/:id' do
      if logged_in?
        if params[:content] == ""
          redirect to "/comints/#{params[:id]}/edit"
        else
          @comints = Comints.find_by_id(params[:id])
          if @comints && @comints.user == current_user
            if @comints.update(content: params[:content])
              redirect to "/comints/#{@comints.id}"
            else 
              redirect to "/comints/#{@comints.id}/edit"
            end
          else 
            redirect to '/comints'
          end
        end
      else 
        redirect to '/login'
      end
    end
  
    delete '/comints/:id/delete' do
      if logged_in?
        @comints = Comints.find_by_id(params[:id])
        if @comints && @comints.user == current_user
          @comints.delete
        end
        redirect to '/comints'
      else
        redirect to '/login'
      end
    end
  end