require File.dirname(__FILE__) + '/../test_helper'

class MaverickContentTest < Test::Unit::TestCase

  def setup
    @settings = { :path => "test/files" }
    Maverick::Content.adaptor = Maverick::Adaptor::Local
    Maverick::Content.settings = @settings
  end

  def test_set_adaptor
    assert_equal Maverick::Adaptor::Local, Maverick::Content.adaptor
    assert_equal "Local", Maverick::Content.description
  end
  
  def test_settings
    assert_equal @settings, Maverick::Content.settings
  end
  
  def test_list
    collection = Maverick::Content.list("example")
    assert_equal 4, collection.length
  end
  
  def test_retrieve
    f = File.new("#{Maverick::Content.settings[:path]}/example/header")
    content = f.read
    object = Maverick::Content.retrieve("header", "example")
    assert_equal content, object.value
  end

end
