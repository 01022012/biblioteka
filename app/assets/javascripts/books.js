$(function() {
  var searchField = $('#query');
  var checkedRadio = $('.query-by:checked');
  
  searchField.attr('placeholder', 'Search by '+$(checkedRadio).val());
  
  $('.query-by').click(function() {
    var value = $(this).val();
    searchField.attr('placeholder', 'Search by '+value);
  });
  
});