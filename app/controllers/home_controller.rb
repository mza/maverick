class HomeController < ApplicationController
  
  def index
    if logged_in?
      @sites = current_user.sites
    end
  end
end
