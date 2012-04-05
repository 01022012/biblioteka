require 'test_helper'

class TaggingTest < ActiveSupport::TestCase
  
  context "tagging instance" do
    
    setup do
      @tagging = Factory(:tagging)
    end
    
    should "not be able to add a second tagging for the same tag and book" do
      new_tagging = Factory.build(:tagging, tag: @tagging.tag, book: @tagging.book)
      
      assert !new_tagging.valid?
    end
    
  end
  
end
