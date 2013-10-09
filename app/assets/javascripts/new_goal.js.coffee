$ ->
  $('form').on 'click', '.add_fields', (e) ->
    e.preventDefault()
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))

  $('.next').on 'click', (e) ->
    $('.prev').show()
    e.preventDefault()
    visible = $('.form_list').find('.visible')
    visible.removeClass('visible')
    visible.hide()
    next = visible.next('li').addClass('visible')
    next.show()
    if next.hasClass('last')
      $('.next').hide()

  $('.prev').on 'click', (e) ->
    e.preventDefault()
    visible = $('.form_list').find('.visible')
    visible.removeClass('visible')
    visible.hide()
    prev = visible.prev('li').addClass('visible')
    prev.show()
    if prev.hasClass('first')
      $('.prev').hide()
    if !prev.hasClass('last')
      $('.next').show()
