$(function() {
  var searchForm = $('#search-form');
  var searchField = $('#query');
  var checkedRadio = $('.query-by:checked');
  
  searchField.attr('placeholder', 'Search by '+$(checkedRadio).val());
  
  $('.query-by').click(function() {
    var value = $(this).val();
    searchField.attr('placeholder', 'Search by '+value);
    if (searchField.val() !== '') {
      searchForm.submit();
    }
  });
  
  searchForm.on('ajax:success', function(evt, data, status, xhr) {
    $('#book-list').html(data);
  });
  
});