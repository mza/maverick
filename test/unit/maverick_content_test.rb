require File.dirname(__FILE__) + '/../test_helper'

class MaverickContentTest < Test::Unit::TestCase
  
  def test_set_adaptor
    Maverick::Content.adaptor = Maverick::Adaptor::Local
    assert_equal Maverick::Adaptor::Local, Maverick::Content.adaptor
    assert_equal "Local", Maverick::Content.description
  end
  
  def test_settings
    settings = { :path => "test/files/example" }
    Maverick::Content.adaptor = Maverick::Adaptor::Local
    Maverick::Content.settings = settings
    assert_equal settings, Maverick::Content.settings
  end
  
  def test_list
    settings = { :path => "test/files" }
    Maverick::Content.adaptor = Maverick::Adaptor::Local
    Maverick::Content.settings = settings
    collection = Maverick::Content.list("example")
    assert_equal 4, collection.length
  end

end
