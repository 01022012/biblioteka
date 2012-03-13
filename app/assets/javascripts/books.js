$(function() {
  var searchForm = $('#search-form');
  var searchField = $('#query');
  var checkedRadio = $('.query-by:checked');
  
  searchField.attr('placeholder', 'Search by '+$(checkedRadio).val());
  
  $('.query-by').live('click', function() {
    var value = $(this).val();
    searchField.attr('placeholder', 'Search by '+value);
    if (searchField.val() !== '') {
      searchForm.submit();
    }
  });
  
  searchForm.live('ajax:success', function(evt, data, status, xhr) {
    $('#book-list').html(data);
  });
  
});