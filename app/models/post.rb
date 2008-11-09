class Post
  
  attr_accessor :title, :content, :object
  
  def initialize(incoming)
    @object = incoming
  end
  
  def title
    @object.key
  end
  
  def content
    @object.value
  end
  
  def last_modified
    @object.about['last-modified'].to_date.to_formatted_s :long
  end
  
end