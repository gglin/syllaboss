$(function() {  
  $('.previewable option').click(function(){
    // show preview panel
    $('.preview-panel').show()

    // show iframe
  	var id = $(this).val();
  	var frame = "resource_preview";
  	var path = $(this).parents(".control-group").data("name");
  	var url = "/"+path+"/" + id + "/preview";	
  	window.open(url, frame);

    resize_preview();
  });


  $(window).resize(function() {
    resize_preview();
  });


  function resize_preview() {
    // set position of preview panel
    var sidebar_width = 280;
    var dayform_width = $('.dayform-span').width();
    var margin_left = sidebar_width + dayform_width;

    var spacer = 20;
    var total_width = $(window).width();
    var panel_width = total_width - margin_left - spacer;

    // console.log(total_width);
    $('.preview-panel').css("left", margin_left)
    $('.preview-panel').css("width", panel_width)
  }

  // Delete action when editing materials in iframe preview
  // var delete_button = $('iframe').contents().find('.delete-btn');
  // console.log(delete_button);

  $('iframe').on('click', '.delete_button', function(e) {
    e.preventDefault();
    console.log('test');
    $('iframe').hide(200);
    return false;
  });
});