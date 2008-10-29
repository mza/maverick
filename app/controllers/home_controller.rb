class HomeController < ApplicationController
  
  require 'aws/s3'
  
  layout 'sites', :except => :index
  
  def index
    if logged_in?
      @sites = current_user.sites
    end
  end
  
  def stats
    begin
      @buckets = Maverick::S3.buckets(:reload)
    rescue Maverick::ConnectionFailedException
      redirect_to :action => :failed
    end
  end
  
  def failed
  end
  
end
