jQuery ->
  $('form').on 'click', '.add_fields', (e) ->
    e.preventDefault()
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
