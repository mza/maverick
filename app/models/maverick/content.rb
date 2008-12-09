module Maverick
  class Content
    
    @@adaptor = nil 
    
    def self.adaptor
      @@adaptor
    end
    
    def self.adaptor=(mod)
      @@adaptor = mod
      extend @@adaptor
    end
    
    def self.logger
      RAILS_DEFAULT_LOGGER
    end
    
  end
end