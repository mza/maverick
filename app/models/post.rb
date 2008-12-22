class Post

  require 'erb'
    
  attr_accessor :title, :content, :object, :prepared_content, :illustration_url, :illustration_credit
  
  def initialize(incoming)
    @object = incoming
    @prepared_content = nil
  end
  
  def title
    @object.key
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
    logger.debug "Checking for illustration: #{self.illustration_url} [ #{self.object_id }]"
    !self.illustration_url.blank?
  end
  
  def illustrated(link, options)
    self.illustration_url = link
    self.illustration_credit = options[:by]
    logger.debug "POST IS ILLUSTRATED: #{self.illustration_url} by #{self.illustration_credit}: [ #{self.object_id} ]"
  end
  
  def last_modified
    self.date.to_formatted_s :long
  end
  
  def date
    d = nil
    logger.debug self.title
    unless @object.metadata[:publication].nil?
      d = @object.metadata[:publication].to_time
      logger.debug "META: #{d}"
    end
    if d.nil?
      d = @object.about['last-modified'].to_time
      logger.debug "ABOUT: #{d}"
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