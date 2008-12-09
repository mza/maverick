require File.dirname(__FILE__) + '/../test_helper'

class MaverickContentTest < Test::Unit::TestCase

  def test_nil_adaptor
    assert_equal nil, Maverick::Content.adaptor
  end
  
  def test_set_adaptor
    Maverick::Content.adaptor = Maverick::Adaptor::Local
    assert_equal Maverick::Adaptor::Local, Maverick::Content.adaptor
    assert_equal "Local", Maverick::Content.description
  end

end
