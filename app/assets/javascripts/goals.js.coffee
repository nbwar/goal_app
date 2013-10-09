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
      goalServerController.requestGoalPartial(data, self)

  $('.goal_block').on 'click', '.add_detail', (e) ->
    e.stopPropagation()
    e.preventDefault()
    goalViewController.showForm($(this))

  $('.goal_block').on 'click', '.new_form', (e) ->
    e.stopPropagation()

  $('.goal_block').on 'submit', '.new_form', (e) ->
    e.preventDefault()
    data = $(this).serialize()
    goalServerController.addNew(data, $(this))

  $('.right_container').on 'submit', '.new_form', (e) ->
    e.preventDefault()
    data = $(this).serialize()
    goalServerController.addNew(data, $(this))

  $('.right_container').on 'click', '.add_detail', (e) ->
    e.stopPropagation()
    e.preventDefault()
    goalViewController.showForm($(this))


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
  renderTemplate: (response, self) ->
    if window.innerWidth > 800
      this.renderTemplateLarge(response)
    else
      this.renderTemplateSmall(response, self)
  renderTemplateLarge: (response) ->
    $('.right_container').html(response)
  renderTemplateSmall: (response, div) ->
    chunk = div.find('.goal_section_container')
    chunk.html(response)
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
  showForm: (link) ->
    form = link.prev()
    form.clone().insertBefore(form).show()
    height = form.height()
    link.hide()
    goalViewController.expandGoalContainer(form, height)
  expandGoalContainer: (el, height) ->
    goalDiv = el.closest('.goal_block')
    goalHeight = goalDiv.outerHeight()
    goalDiv.animate {
      height: goalHeight + height
    }, 200
  unexpandGoalContainer: (el, height) ->
    goalDiv = el.closest('.goal_block')
    goalHeight = goalDiv.outerHeight()
    goalDiv.animate {
      height: goalHeight - height
    }, 200



goalServerController =
  addNew: (data, self) ->
    $.ajax '/add_goal_detail',
      type: 'post',
      data: data,
      error: (jqXHR, textStatus, errorThrown) ->
        console.log(errorThrown)
      success: (response, textStatus) ->
        ul = self.prev()
        ul.append(response)
        # if window.innerWidth <= 800
          # formHeight = self.innerHeight()
          # newHeight = ul.find('li').last().innerHeight()
          # height = formHeight - newHeight
          # console.log(height);
          # goalViewController.expandGoalContainer(self, height)
        self.siblings('.add_detail').show()
        self.remove()

  requestGoalPartial: (data, el) ->
    $.ajax '/show_goal',
      type: 'get',
      data: data,
      error: (jqXHR, textStatus, errorThrown) ->
        console.log(errorThrown)
      success: (response, textStatus) ->
        goalViewController.renderTemplate(response, el)
