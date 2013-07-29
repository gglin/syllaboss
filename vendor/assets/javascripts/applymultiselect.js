$(document).ready(function() {

  // $('.dropdown input, .dropdown label').click(function (event) {
  //   event.stopPropagation();
  // });

  // window.prettyPrint() && prettyPrint();

  $('.multi-select').multiselect({
    includeSelectAllOption: true,
    enableFiltering: true,
    maxHeight: 300,
    buttonWidth: '400px',
    buttonClass: 'btn btn-primary'
  });

});