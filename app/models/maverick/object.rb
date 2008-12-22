module Maverick
  class Object

    attr_accessor :filename, :content, :name, :date
    
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
    
    def about
      { 'last-modified' => self.date }
    end
    
    def metadata
      {}
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
        self.date = File.mtime(self.filename)
      end
      
      def logger
        RAILS_DEFAULT_LOGGER
      end
  end
end