class PagesController < ApplicationController
  
  def index
    if params[:id].nil?
      redirect_to_default
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
  
  private

  def redirect_to_default
    if default_site.nil?
      redirect_to :action => :not_found
    else
      redirect_to :id => default_site
    end
  end
  
end
