module Maverick
  class Object

    attr_accessor :filename, :content, :name
    
    def initialize(options)
      self.filename = options[:filename]
      self.name = options[:name]
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
        file = File.new(self.filename)
        self.content = file.read
      end
    
  end
end