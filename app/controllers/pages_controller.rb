class PagesController < ApplicationController

  # GET: /pages
  get "/pages" do
    erb :"/pages/index.html"
  end

  # GET: /pages/new
  get "/pages/new" do
    erb :"/pages/new.html"
  end

  # POST: /pages
  post "/pages" do
    redirect "/pages"
  end

  # GET: /pages/5
  get "/pages/:id" do
    erb :"/pages/show.html"
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
  delete "/pages/:id/delete" do
    redirect "/pages"
  end
end
