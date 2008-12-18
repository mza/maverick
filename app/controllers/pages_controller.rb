class PagesController < ApplicationController
  
  def index
    if params[:id].nil?
      redirect_to :action => :not_found
    else
      @site = Site.find_by_nickname(params[:id])
      @posts = @site.posts
    end
  end
  
  def styles
    @site = Site.find_by_nickname(params[:id])
    render :text => @site.stylesheet.content
  end
  
  def show
    @site = Site.find_by_nickname(params[:id])
    @post = @site.post(params[:page])
  end
  
  def not_found
  end
  
end
