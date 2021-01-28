$(document).ready(function() {
  // minimalny odstęp między datami w panelu wyszukiwania
  $('#pick, #return').on('change', function(){
    $('#return').attr('min', $('#pick').val());
  });


  var basic_price = parseInt($(this).find('#price-total').text(), 10);
  var b_packet1 = basic_price + parseInt($(this).find('#price-p1').text(), 10);
  var b_packet2 = basic_price + parseInt($(this).find('#price-p2').text(), 10);
  var b_packet3 = basic_price + parseInt($(this).find('#price-p3').text(), 10);
  var additional = 0;
  var total = 0;

  $('#packet1').click(function() {
	total = additional + b_packet1;
    $('#price-total').text(total);
  });

  $('#packet2').click(function() {
	total = additional + b_packet2;
    $('#price-total').text(total);
  });

  $('#packet3').click(function() {
	total = additional + b_packet3;
    $('#price-total').text(total);
  });

  $("#extra_seat").click(function() {
    if ($(this).is(":checked")){
      $('#price-total').text(total + 20);
	  total = total + 20;
	  additional = additional + 20;
	}
    else {
	  total = total - 20;
	  additional = additional - 20;
      $('#price-total').text(total);
    }
  });

  $("#if_abroad").click(function() {
    if ($(this).is(":checked")){
      $('#price-total').text(total + 40);
	  total = total + 40;
	  additional = additional + 40;
	}
    else {
	  total = total - 40;
	  additional = additional - 40;
      $('#price-total').text(total);
    }
  });

  $("#if_more_users").click(function() {
    if ($(this).is(":checked")){
      $('#price-total').text(total + 10);
	  additional = additional + 10;
	  total = total + 10;
	}
    else {
	  total = total - 10;
	  additional = additional - 10;
      $('#price-total').text(total);
    }
  });
});