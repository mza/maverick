module Maverick
  class Object

    attr_accessor :filename, :content, :name
    
    def initialize(options)
      self.filename = options[:filename]
      self.name = options[:name]
      
      unless options[:content].nil?
        self.content = options[:content]
      else 
        load_content
      end
        
    end
    
    def key
      self.name
    end
    
    def value
      if self.content.nil?
        load_content
      end
      self.content
    end
    
    private
    
      def load_content
        begin
          file = File.new(self.filename)
        rescue
          logger.debug "FILE NOT FOUND: #{self.filename}"
          raise Maverick::FileNotFoundException, "File not found: #{self.filename}"
        end
        self.content = file.read
      end
      
      def logger
        RAILS_DEFAULT_LOGGER
      end
  end
end