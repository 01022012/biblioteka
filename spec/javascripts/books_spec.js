//= require books

describe("books.js", function() {

  beforeEach(function() {
    loadFixtures("book_search");
  });
  
  it("should set the search field placeholder to match the value of a clicked radio", function() {
    $('#query-by-isbn').click();
    
    expect($('#query').attr('placeholder')).toEqual("Search by isbn");
  });
  
  it("should submit the search form when a radio is clicked, if the search field is not empty", function() {
    var submitSpy = jasmine.createSpy().andReturn(false);
    $('#search-form').on('submit', submitSpy);
    
    $('#query').val('my search term');
    $('#query-by-isbn').click();
    
    expect(submitSpy).toHaveBeenCalled();
  });
  
  it("should not submit the search form when a radio is clicked, if the search field is empty", function() {
    var submitSpy = jasmine.createSpy().andReturn(false);
    $('#search-form').on('submit', submitSpy);
    
    $('#query').val('');
    $('#query-by-isbn').click();
    
    expect(submitSpy).not.toHaveBeenCalled();
  });
  
  it("should replace the contents of the book list when the search form gets a response", function() {
    var newHtml = "<h2>New contents</h2>";
    
    $('#search-form').trigger('ajax:success', newHtml);
    
    expect($('#book-list').html()).toEqual(newHtml);
  });
  
});