module Maverick
  class S3
  
    require 'aws/s3'
    include AWS::S3
    
    cattr_accessor :settings
    
    def self.load_settings
      @@settings = YAML.load(File.open("#{Rails.root}/config/s3.yml")).symbolize_keys
    end
    
    def self.connect
      if @@settings.blank?
        load_settings
      end
      
      aws = nil
      begin
        aws = AWS::S3::Base.establish_connection!(
           :access_key_id     => settings[:access_key_id],
           :secret_access_key => settings[:secret_access_key]
        )
      rescue 
        raise Maverick::ConnectionFailedException
      end
      
      # unless aws.http.active?
      #   raise Maverick::ConnectionFailedException
      # end
      
    end
    
    def self.reconnect
      if AWS::S3::Base.connected?
        AWS::S3::Base.disconnect!
      end
      connect
    end
        
    def self.store(file_name, data, bucket)
      connect
      # For public access control - :access => :public_read
      S3Object.store(file_name, data, bucket, :access => :public_read)
    end
    
    def self.remove(name, bucket)
      S3Object.delete(name, bucket)
    end
        
    def self.find_object(name, bucket)
      connect
      begin
        S3Object.find(name, bucket)
      rescue AWS::S3::NoSuchKey
        raise Maverick::NoSuchKeyException
      end
    end
    
    def self.find_bucket(name)
      connect
      Bucket.find(name)
    end
    
    def self.buckets(reload = nil)      
      connect
      Service.buckets(reload)
    end
    
    def self.create_bucket(name)
      connect
      Bucket.create(name)
    end
    
    def self.delete_bucket(name)
      connect
      Bucket.delete(name)
    end
    
    def self.logger
      RAILS_DEFAULT_LOGGER
    end
  
  end
end