require 'test_helper'

class TestTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Test.new.valid?
  end
end
