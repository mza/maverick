# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  attr_accessor :working_post, :working_site, :assets, :illustration_url, :illustration_credit
  
  def titled(title)
    working_post.headline = title
    "<div class='title'><h1>#{title}</h1></div>"
  end
  
  def preview(preview)
    working_post.preview = preview
  end
    
  def dated
    "<div class='date'>#{working_post.last_modified}</div>"
  end
    
  def method_missing(method, *params)
    unless working_post.nil?
      begin
        logger.debug "METHOD MISSING SEND #{method}: [ #{working_post.class.to_s} #{working_post.object_id} ]"
        working_post.send(method, *params)
      rescue NoMethodError
        raise NoMethodError.new("Method not found in ApplicationHelper or Post class: #{method}")
      end
    end
  end
    
  def illustration_url
    @illustration_url = ""
    assets.each do |post|
      self.working_post = post
      post.prepare_content(binding)
      if post.illustrated?
        @illustration_url = post.illustration_url
        @illustration_credit = post.illustration_credit
      end
    end
    @illustration_url
  end
  
  def overview(post, options)
    self.working_post = post
    self.working_site = options[:for]
    self.assets = options[:assets_from]
    begin
      unless post.prepared?
        post.prepare_content(binding)
      end
    rescue Maverick::NoSuchKeyException => e
      raise Maverick::NoSuchKeyException, "Failed to prepare content: #{e}"
    end
    render :partial => "overview", :locals => { :post => post }
  end
      
  def prepare(post, options)
    self.working_post = post
    self.working_site = options[:for]
    self.assets = options[:assets_from]
    begin
      unless post.prepared?
        post.prepare_content(binding)
      end
    rescue Maverick::NoSuchKeyException => e
      raise Maverick::NoSuchKeyException, "Failed to prepare content: #{e}"
    end
    post.prepared_content
  end
  
  # legacy calls
  
  def date
    dated
  end
  
  def add_page_details(options)
    titled(options)
  end
      
end
