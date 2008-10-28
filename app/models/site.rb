class Site < ActiveRecord::Base
  
  require 'aws/s3'
  include AWS::S3
  
  belongs_to :user
  validates_presence_of :name, :nickname, :url
  
  after_create :create_bucket
  before_destroy :destroy_bucket
  
  @@bucket_prefix = ""
  
  def create_bucket
    Maverick::S3.connect
    logger.debug "CREATING BUCKET: #{self.bucket_name}"
    Bucket.create(self.bucket_name)
  end
  
  def destroy_bucket
    Maverick::S3.connect
    Bucket.delete(self.bucket_name)
  end
  
  def bucket_name
    bucket_prefix + "_#{self.nickname}" 
  end
  
  def bucket_prefix
    @@bucket_prefix
  end
  
  def self.bucket_prefix
    @@bucket_prefix
  end
  
  def self.bucket_prefix=(new_prefix)
    @@bucket_prefix = new_prefix
  end
  
end
