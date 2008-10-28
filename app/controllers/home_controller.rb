class HomeController < ApplicationController
  
  require 'aws/s3'
  
  layout 'sites', :only => :stats
  
  def index
    if logged_in?
      @sites = current_user.sites
    end
  end
  
  def stats
    @buckets = Maverick::S3.buckets
  end
  
end
