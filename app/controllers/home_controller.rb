class HomeController < ApplicationController
    
  layout 'sites', :except => :index
  
  def index
    if logged_in?
      @sites = current_user.sites
    end
  end
    
  def failed
  end
  
end
