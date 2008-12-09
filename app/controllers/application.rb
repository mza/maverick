# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  include AuthenticatedSystem

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '2a40e9a19e3a8a7c890b447cb7175ea6'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
    
  BUCKET_PREFIX = "maverick_s3"
  Site.bucket_prefix = BUCKET_PREFIX
  
  Maverick::Content.adapator = Maverick::Adaptor::Local
  
  def bucket_prefix
    BUCKET_PREFIX
  end
      
end
