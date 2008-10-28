class SitesController < ApplicationController

  before_filter :login_required
  
  def new
    @site = Site.new
  end
  
  def create
    @site = Site.new(params[:site])
    @site.user = current_user
    if @site.save
      flash[:notice] = "New site created."
      logger.debug "SAVE!"
      redirect_to :controller => :home
    else
      logger.debug "FAIL!"
      flash[:warning] = "Site creation failed"
      render :action => :new 
    end
  end
  
end
