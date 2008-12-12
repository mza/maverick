require File.dirname(__FILE__) + '/../test_helper'

class MaverickContentTest < Test::Unit::TestCase

  def setup
    @settings = { :path => "test/files" }
    @object = Maverick::Object.new({ :name => "header", :filename => "#{@settings[:path]}/example/header" })
  end
  
  def test_attributes
    assert_equal "header", @object.name
    assert_equal "#{@settings[:path]}/example/header", @object.filename
  end
  
  def test_content
    content = File.new("#{@settings[:path]}/example/header").read
    assert_equal content, @object.value
  end
  
end
