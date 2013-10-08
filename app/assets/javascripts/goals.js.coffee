$ ->
  if window.innerWidth <= 800
    $('.right_container').hide();


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
    if window.innerWidth > 800
      this.renderTemplateLarge(data)
    else
      this.renderTemplateSmall(data)
  renderTemplateLarge: (data) ->
    $('.right_container').html(data)
  renderTemplateSmall: (data) ->
    console.log(data)

# window.onresize = (event) ->
#   if(window.innerWidth <= 800)
#     $('.right_container').hide()
#     goalId = $('.goal_header').data('goal-id')
#     console.log(goalId);
#     console.log($('.list_of_goals a[data-goal-id="' + goalId + '"]').closest('.goal_block'))
#     window.onresize.unbind()

#   if(window.innerWidth > 800)
#     $('.right_container').show()
