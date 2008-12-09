module Maverick
  module Adaptor
    module Local
      
      @@settings = nil
          
      def description
        "Local"
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
      end
    
      def list(name)
      end
      
      def create_location(name)
      end
      
      def delete_location(name)
      end
              
    end
    
  end
end