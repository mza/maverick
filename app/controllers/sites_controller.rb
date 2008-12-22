class SitesController < ApplicationController

  require 'aws/s3'
  
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
  
  def remove
    @site = Site.find(params[:id])
    @site.remove_post(params[:post])
    flash[:notice] = "Post removed from S3"
    redirect_to :controller => :sites, :action => :show, :id => @site.id
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
      publication_date = DateTime.civil(params[:import][:"date(1i)"].to_i, params[:import][:"date(2i)"].to_i, params[:import][:"date(3i)"].to_i, params[:import][:"date(4i)"].to_i, params[:import][:"date(5i)"].to_i)
      logger.debug "PUB DATE: #{publication_date}"
      @site.add_post(params[:import][:stub], publication_date, data)
      flash[:notice] = "Post uploaded"
    else
      flash[:notice] = "Upload failed: file was empty!"
    end
    
    redirect_to :action => :show, :id => @site.id
  end
  
end
