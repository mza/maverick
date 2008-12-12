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
        if @@settings.blank?
          load_settings
        end
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
        File.open("#{path}/#{bucket}/#{file_name}", 'w') do |f|
          f.write(data)
        end
      end
        
      def remove(name, bucket)
      end
    
      def retrieve(name, bucket)
        Maverick::Object.new({ :filename => "#{path}/#{name}" })
      end
    
      def list(name)
        collection = []
        Dir.new("#{path}/#{name}").entries.reject { |e| [ "..", "." ].include? e }.each do |file|
          collection << Maverick::Object.new({ :name => file, :filename => "#{path}/#{name}/#{file}" })
        end
        collection
      end
      
      def create_location(name)
        new_dir = "#{self.path}/#{name}"
        logger.debug "Creating in: #{new_dir}"
        Dir.mkdir(new_dir) unless File.directory?(new_dir) 
      end
      
      def delete_location(name)
      end
      
      def path
        "#{settings[:path]}"
      end
              
    end
    
  end
end