class Post

  require 'erb'
    
  attr_accessor :title, :preview, :content, :object, :prepared_content, :illustration_url, :illustration_credit, :headline
  
  def initialize(incoming)
    @object = incoming
    @prepared_content = nil
    @title = @object.key
  end
    
  def prepared?
    !@prepared_content.blank?
  end
  
  def content
    begin
      @object.value
    rescue Maverick::NoSuchKeyException => e 
      raise Maverick::NoSuchKeyException, "Content not prepared. #{e}"     
    end
  end
  
  def illustrated?
    !self.illustration_url.blank?
  end
  
  def illustrated(link, options)
    self.illustration_url = link
    self.illustration_credit = options[:by]
  end
  
  def last_modified
    self.date.to_formatted_s :long
  end
  
  def date
    d = nil
    logger.debug self.title
    unless @object.metadata[:publication].nil?
      d = @object.metadata[:publication].to_time
    end
    if d.nil?
      d = @object.about['last-modified'].to_time
    end
    d
  end
  
  def prepare_content(b)
    template = ERB.new self.content
    self.prepared_content = template.result(b)
  end
  
  def logger
    RAILS_DEFAULT_LOGGER
  end
  
end