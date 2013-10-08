$ ->
  $('form').on 'click', '.add_fields', (e) ->
    e.preventDefault()
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))

  $('.goal_link').on 'click', (e) ->
    e.preventDefault()
    goalId = $(this).data('goal-id');
    data = goal: goalId
    $.ajax '/show_goal',
      type: 'get',
      data: data,
      error: (jqXHR, textStatus, errorThrown) ->
        console.log(errorThrown)
      success: (data, textStatus) ->
        goalViewController.renderTemplate(data)


goalViewController =
  renderTemplate: (data) ->
    $('.right_container').html(data)

window.onresize = (event) ->
  if(window.innerWidth < 800)
    $('.right_container').hide()
  if(window.innerWidth > 800)
    $('.right_container').show()
