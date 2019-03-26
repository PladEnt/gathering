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
    erb :"/pages/edit.html"
  end

  patch "/pages/:id" do
    redirect "/pages/:id"
  end

  post "/pages/:id/delete" do
    if logged_in?
      @page = Page.find_by_id(params[:id])
      @page.delete
      redirect to "/pages"
    else
      redirect to '/login'
    end
  end
end
