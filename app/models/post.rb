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
  
end