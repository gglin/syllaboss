$(function(){

  //adds back a toggle event method to jQuery

  $.fn.toggleClick = function(){

    var functions = arguments ;

    return this.click(function(){
            var iteration = $(this).data('iteration') || 0;
            functions[iteration].apply(this, arguments);
            iteration = (iteration + 1) % functions.length ;
            $(this).data('iteration', iteration);
    });
  };

  //activate stupid table (makes tables sortable)

  $('table').stupidtable(); //css at school_day_index.css

  var asc  = '⬆'; //set ascii text character for up arrow
  var desc = '⬇'; //set ascii text character for down arrow

  //toggle asc desc arrows

  $('th').each(function(){ //for each th check if it has a data-sort attribute
    var dataAttribute = $(this).attr("data-sort");
    console.log(dataAttribute);
    if (typeof dataAttribute !== 'undefined') { //if yes add toggle arrows
      var self = $(this);
      self.append('<span class="arrow">'+asc+'</span>');
      self.toggleClick(function(){
        self.find('span.arrow').text(desc);
      }, function(){
        self.find('span.arrow').text(asc);
      });
    }
  });

});  