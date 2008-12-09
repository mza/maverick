class Site < ActiveRecord::Base
    
  belongs_to :user
  validates_presence_of :name, :nickname, :url
  
  after_create :create_location
  before_destroy :destroy_location
  
  attr_accessor :collection
  cattr_accessor :bucket_prefix
  
  def posts
    all_assets :filter_by => reserved_names
  end
    
  def all_assets(options = {})
    if self.collection.blank?
      self.collection = Maverick::Content.list(self.bucket_name)
    end
    p = []
    self.collection.objects.each do |object|
      unless options[:filter_by].blank?
        unless options[:filter_by].include? object.key
          unless object.key.match("png")
            p << Post.new(object)
          end
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
  
  def remove_post(title)
    Maverick::Content.remove(title, self.bucket_name)
  end
  
  def post(title)
    Post.new(Maverick::Content.retrieve(title, self.bucket_name))
  end
  
  def add_post(title, file)
    Maverick::Content.store(title, file.read, self.bucket_name)
  end

  def stylesheet
    begin
      Maverick::Content.retrieve("styles", self.bucket_name).value
    rescue Maverick::NoSuchKeyException
      ""
    end
  end
  
  def header
    begin
      Post.new Maverick::Content.retrieve("header", self.bucket_name)
    rescue Maverick::NoSuchKeyException
      "HEADER"
    end
  end
  
  def footer
    begin
      Post.new Maverick::Content.retrieve("footer", self.bucket_name)
    rescue Maverick::NoSuchKeyException
      "FOOTER"
    end
  end
  
  def create_location
    Maverick::Content.create_location(self.bucket_name)
  end
  
  def destroy_location
    Maverick::Content.delete_location(self.bucket_name)
  end
  
  def location_name
    bucket_prefix + "_#{self.nickname}"
  end
  
  def bucket_prefix
    @@bucket_prefix
  end
    
end
