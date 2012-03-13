$(function() {

  $('.reserve-link').live('ajax:success', function(evt, data, status, xhr) {
    $('#reservation-form').hide();
    $('#reservation-status').html('<span class="label important">Reserved by '+data.user.email+'</span>');
    $('#reservation-links').html('<a href="/books/'+data.book_id+'/reservations/'+data.id+'/free" class="btn" data-method="put">Free</a>');
  });
  
});
