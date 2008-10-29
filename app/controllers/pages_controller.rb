class PagesController < ApplicationController
  
  def index
    @site = Site.find_by_nickname(params[:id])
  end
  
end
