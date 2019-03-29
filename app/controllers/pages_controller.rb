class PagesController < ApplicationController

  get "/pages" do
    @pages = Page.all
    erb :"/pages/index.html"
  end

  get "/pages/new" do
    erb :"/pages/new.html"
  end

  post "/pages" do
    if params[:title] == ""
      redirect to '/pages/new'
    else
      @page = Page.new(:title => params[:title])
      @page.user_id = current_user.id
      @page.save
      redirect to "/pages/#{@page.id}"
    end
  end

  get "/pages/:id" do
    if logged_in?
      @page = Page.find_by_id(params[:id])
      erb :"/pages/show.html"
    else
      redirect to '/login'
    end
  end

  post "/pages/:id/comments" do
    if logged_in?
      @page = Page.find_by_id(params[:id])
      @page.comments.create(user: current_user, content: params[:content])
      redirect to "/pages/#{@page.id}"
    else
      redirect to '/login'
    end
  end

  get "/pages/:id/edit" do
    if logged_in?
      @page = Page.find_by_id(params[:id])
      erb :"/pages/edit.html"
    else
      redirect to '/login'
    end
  end

  post "/pages/:id" do
    if logged_in?
      @page = Page.find_by_id(params[:id])
      if @page && @page.user == current_user
        if @page.update(title: params[:title])
          redirect to "/pages/#{@page.id}"
        else 
          erb :"/pages/edit.html"
        end
      else 
        binding.pry

        redirect to "/pages/#{@page.id}"
      end
    else 
      redirect to '/login'
    end
  end

  post "/pages/:id/delete" do
    if logged_in?
      @page = Page.find_by_id(params[:id])
      if @page && @page.user == current_user
        @page.delete
      end
      redirect to "/pages"
    else
      redirect to '/login'
    end
  end
end
