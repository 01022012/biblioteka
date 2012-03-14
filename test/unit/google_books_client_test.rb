require 'test_helper'

class GoogleBooksClientTest < ActiveSupport::TestCase

  context "ISBN normalization" do
    
    should "prefix with ISBN" do
      assert_equal "ISBN1234", GoogleBooksClient.normalize_isbn("1234")
    end
    
    should "not prefix with ISBN if already prefixed" do
      assert_equal "ISBN5678", GoogleBooksClient.normalize_isbn("ISBN5678")
    end
    
    should "remove dashes and whitespace" do
      assert_equal "ISBN1234", GoogleBooksClient.normalize_isbn("12-3 4")
    end
    
  end
  
  context "parsing" do
    
    setup do
      @no_results_json = IO.read("#{Rails.root}/test/google_books_fixtures/no_results.json")
      @rails_json = IO.read("#{Rails.root}/test/google_books_fixtures/agile_web_development_with_rails.json")
    end
    
    should "return nil when the response contains no results" do
      book = GoogleBooksClient.parse(@no_results_json)
      
      assert_nil book
    end
    
    should "return the first Book in the response" do
      book = GoogleBooksClient.parse(@rails_json)
      
      assert       book
      assert_equal "Agile Web Development with Rails", book.title
      assert_match  /Rails/, book.description
      assert_equal "Sam Ruby, Dave Thomas, David Heinemeier Hansson, Leon Breedt", book.authors
      assert_equal "1934356549", book.isbn
    end
    
  end
  
end