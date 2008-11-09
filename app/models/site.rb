class Site < ActiveRecord::Base
    
  belongs_to :user
  validates_presence_of :name, :nickname, :url
  
  after_create :create_bucket
  before_destroy :destroy_bucket
  
  attr_accessor :bucket
  cattr_accessor :bucket_prefix
  
  def posts
    all_assets :filter_by => reserved_names
  end
    
  def all_assets(options = {})
    if self.bucket.blank?
      self.bucket = Maverick::S3.find_bucket(self.bucket_name)
    end
    p = []
    self.bucket.objects.each do |object|
      unless options[:filter_by].blank?
        unless options[:filter_by].include? object.key
          p << Post.new(object)
        end
      else
        p << Post.new(object)
      end
    end
    p 
  end
  
  def reserved_names
    [ "header", "footer", "styles.css" ]
  end
  
  def post(title)
    Post.new(Maverick::S3.find_object(title, self.bucket_name))
  end
  
  def add_post(title, file)
    Maverick::S3.store(title, file.read, self.bucket_name)
  end

  def stylesheet
    begin
      Maverick::S3.find_object("styles", self.bucket_name).value
    rescue Maverick::NoSuchKeyException
      ""
    end
  end
  
  def header
    begin
      Maverick::S3.find_object("header", self.bucket_name).value
    rescue Maverick::NoSuchKeyException
      "HEADER"
    end
  end
  
  def footer
    begin
      Maverick::S3.find_object("footer", self.bucket_name).value
    rescue Maverick::NoSuchKeyException
      "FOOTER"
    end
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
