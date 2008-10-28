module Maverick
  class S3
  
    require 'aws/s3'
    include AWS::S3
    
    def self.connect
      AWS::S3::Base.establish_connection!(
         :access_key_id     => '0BQ9SCFHD5BG50YG2JG2',
         :secret_access_key => 'VlDdK4jVtoswxYq9QrXjgHnGZhlv3dGs8BQsP9qe'
      )
    end
    
    def self.buckets
      Service.buckets
    end
  
  end
end