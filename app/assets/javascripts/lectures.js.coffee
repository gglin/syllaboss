$(document).ready ->
  $('.remove_fields').on 'click', '.remove_fields', (event) ->
    event.preventDefault()
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    console.log("test")

