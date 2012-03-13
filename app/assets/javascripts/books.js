$(function() {
  
  $(document).on('click', '.query-by', function() {
    var value = $(this).val();
    var searchField = $('#query');
    searchField.attr('placeholder', 'Search by '+value);
    if (searchField.val() !== '') {
      $('#search-form').submit();
    }
  });
  
  $(document).on('ajax:success', '#search-form', function(evt, data, status, xhr) {
    $('#book-list').html(data);
  });
  
});
