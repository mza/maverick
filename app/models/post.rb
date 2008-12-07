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
    @object.value
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
    @object.about['last-modified'].to_date.to_formatted_s :long
  end
  
  def prepare_content(b)
    template = ERB.new self.content
    self.prepared_content = template.result(b)
  end
  
  def logger
    RAILS_DEFAULT_LOGGER
  end
  
end