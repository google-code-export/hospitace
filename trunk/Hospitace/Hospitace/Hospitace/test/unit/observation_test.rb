require 'test_helper'

class ObservationTest < ActiveSupport::TestCase
   test_the_truth do
     assert true
   end
   
  test "should not save post without title" do
    observation = Observation.new
    assert !observation.save
  end
end
