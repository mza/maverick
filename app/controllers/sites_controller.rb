class SitesController < ApplicationController

  require 'aws/s3'
  include Maverick
  
  before_filter :login_required
  
  def show
    @site = Site.find(params[:id])
  end
  
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

  def edit
    @site = Site.find(params[:id])
  end

  def update
    @site = Site.find(params[:id])
  end
  
  def delete
    @site = Site.find(params[:id])
    if @site.destroy
      flash[:notice] = "Site removed"
      redirect_to :controller => :home, :action => :index
    end
  end
  
  def upload
    @site = Site.find(params[:id])
  end
  
  def import
    @site = Site.find(params[:id])
    data = params[:import][:upload]
    
    unless data.blank?
      @site.add_post(params[:import][:stub], data)
      flash[:notice] = "Post uploaded"
    else
      flash[:notice] = "Upload failed: file was empty!"
    end
    
    redirect_to :action => :show, :id => @site.id
  end
  
end
