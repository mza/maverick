module Maverick
  class S3
  
    require 'aws/s3'
    include AWS::S3
    
    def self.connect
      aws = nil
      begin
        aws = AWS::S3::Base.establish_connection!(
           :access_key_id     => '0BQ9SCFHD5BG50YG2JG2',
           :secret_access_key => 'VlDdK4jVtoswxYq9QrXjgHnGZhlv3dGs8BQsP9qe'
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
      S3Object.store(file_name, data, bucket)
    end
    
    def self.find_object(name, bucket)
      S3Object.find(name, bucket)
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