class Site < ActiveRecord::Base
    
  belongs_to :user
  validates_presence_of :name, :nickname, :url
  
  after_create :create_bucket
  before_destroy :destroy_bucket
  
  cattr_accessor :bucket_prefix
  
  def create_bucket
    Maverick::S3.create_bucket(self.bucket_name)
  end
  
  def destroy_bucket
    Maverick::S3.delete_bucket(self.bucket_name)
  end
  
  def bucket_name
    bucket_prefix + "_#{self.nickname}" 
  end
  
  def bucket_prefix
    @@bucket_prefix
  end
    
end
