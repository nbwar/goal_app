$ ->
  if window.innerWidth <= 800
    $('.right_container').hide();


  $('form').on 'click', '.add_fields', (e) ->
    e.preventDefault()
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))

  $('.goal_block').on 'click', (e) ->
    e.preventDefault()
    self = $(this);
    if self.height() > 30 && window.innerWidth <= 800
      goalViewController.collapseGoal(self)
    else
      goalId = self.find('a').data('goal-id');
      data = goal: goalId
      $.ajax '/show_goal',
        type: 'get',
        data: data,
        error: (jqXHR, textStatus, errorThrown) ->
          console.log(errorThrown)
        success: (data, textStatus) ->
          goalViewController.renderTemplate(data, self)

  doit =
  $(window).resize (e) ->
    clearTimeout(doit)
    doit = setTimeout ->
      goalViewController.unexpandGoals()
      if window.innerWidth <= 800
        smallResize()
      else
        largeResize()
    , 100


smallResize = ->
  $('.right_container').hide()
  goalId = $('.goal_header').data('goal-id')
  $('.list_of_goals a[data-goal-id="' + goalId + '"]').closest('.goal_block')

largeResize = ->
  $('.right_container').show()


goalViewController =
  renderTemplate: (data, self) ->
    if window.innerWidth > 800
      this.renderTemplateLarge(data)
    else
      this.renderTemplateSmall(data, self)
  renderTemplateLarge: (data) ->
    $('.right_container').html(data)
  renderTemplateSmall: (data, div) ->
    chunk = div.find('.goal_section_container')
    chunk.html(data)
    height = chunk.height()
    chunk.slideDown(200);
    div.animate {
      height: height + 44
    }, 200
  collapseGoal: (div) ->
    div.find('.goal_section_container').slideUp(200)
    div.animate {
      height: 44
    }, 200
  unexpandGoals: ->
    self = this
    $('.left_container .list_of_goals').children().each (index, element) ->
      self.collapseGoal($(element).find('.goal_block'))

