module Maverick
  module Adaptor
    module Local
            
      @@settings = nil
      
      def description
        "Local"
      end
    
      def settings=(setup)
        @@settings = setup
      end
      
      def settings
        @@settings
      end
    
      def load_settings
        @@settings = YAML.load(File.open("#{Rails.root}/config/local.yml")).symbolize_keys
      end
    
      def connect
        if @@settings.blank?
          load_settings
        end
      end
    
      def reconnect
        connect
      end
        
      def store(file_name, data, bucket)
        connect
        File.open("#{path}/#{file_name}", 'w') do |f|
          f.write(data)
        end
      end
        
      def remove(name, bucket)
      end
    
      def retrieve(name, bucket)
        Maverick::Object.new({ :filename => "#{path}/#{name}" })
      end
    
      def list(name)
        collection = Maverick::Collection.new
        Dir.new("#{path}/#{name}").entries.reject { |e| [ "..", "." ].include? e }.each do |file|
          collection << file
        end
        collection
      end
      
      def create_location(name)
      end
      
      def delete_location(name)
      end
      
      def path
        settings[:path]
      end
              
    end
    
  end
end