class PagesController < ApplicationController
  
  def index
    @site = Site.find_by_nickname(params[:id])
    @posts = @site.posts
    @header = @site.header
    @footer = @site.footer
  end
  
  def show
    @site = Site.find_by_nickname(params[:id])
    @post = @site.post(params[:page])
    @header = @site.header
    @footer = @site.footer
  end
  
end
