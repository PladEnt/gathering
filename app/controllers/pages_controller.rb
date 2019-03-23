class PagesController < ApplicationController

  # GET: /pages
  get "/pages" do
    @pages = Page.all
    erb :"/pages/index.html"
  end

  # GET: /pages/new
  get "/pages/new" do
    erb :"/pages/new.html"
  end

  # POST: /pages
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

  # GET: /pages/5
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

  # GET: /pages/5/edit
  get "/pages/:id/edit" do
    erb :"/pages/edit.html"
  end

  # PATCH: /pages/5
  patch "/pages/:id" do
    redirect "/pages/:id"
  end

  # DELETE: /pages/5/delete
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
