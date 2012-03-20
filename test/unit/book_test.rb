require 'test_helper'

class BookTest < ActiveSupport::TestCase
  
  context 'book instance' do
    
    setup do
      @book = Factory(:book)
    end

    should "have valid book" do
      assert @book.valid?
    end
    
    should have_many(:reservations)

    should validate_presence_of   :title
    should validate_uniqueness_of :title
    should validate_presence_of   :authors
    
    should validate_presence_of(:isbn).with_message(/is not a valid ISBN/)
    should_not allow_value("dfjlaksfjds").for(:isbn)
  end
  
  context 'tagging' do
    
    setup do
      @book = Factory(:book)
      
      @untagged_tag = Factory(:tag)
      
      @tagged_tag = Factory(:tag)
      @book.tags << @tagged_tag
    end
    
    should "tag with a completely new tag" do
      tag = @book.tag_with("some new tag")
      
      assert tag
      assert tag.persisted?
      assert @book.tags.include?(tag)
    end
    
    should "tag with a tag that already exists but not for this book" do
      tag = @book.tag_with(@untagged_tag.name)
      
      assert tag
      assert_equal @untagged_tag, tag
    end
    
    should "not tag with a tag that already exists" do
      tag = @book.tag_with(@tagged_tag.name)
      
      assert !tag
    end
    
  end
  
end
