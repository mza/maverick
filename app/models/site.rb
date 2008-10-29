class Site < ActiveRecord::Base
    
  belongs_to :user
  validates_presence_of :name, :nickname, :url
  
  after_create :create_bucket
  before_destroy :destroy_bucket
  
  attr_accessor :bucket
  cattr_accessor :bucket_prefix
  
  def posts
    if self.bucket.blank?
      self.bucket = Maverick::S3.find_bucket(self.bucket_name)
    end
    p = []
    self.bucket.objects.each do |object|
      p << Post.new(object)
    end
    p
  end
  
  def post(title)
    Post.new(Maverick::S3.find_object(title, self.bucket_name))
  end
  
  def add_post(title, file)
    Maverick::S3.store(title, file.read, self.bucket_name)
  end
  
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
