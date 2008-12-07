class PagesController < ApplicationController
  
  def index
    @site = Site.find_by_nickname(params[:id])
    @posts = @site.posts
  end
  
  def show
    @site = Site.find_by_nickname(params[:id])
    @post = @site.post(params[:page])
  end
  
end
