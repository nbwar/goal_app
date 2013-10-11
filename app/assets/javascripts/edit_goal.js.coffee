$ ->
  $('.goal_block').on 'click', '.edit', (e) ->
    e.preventDefault()
    e.stopPropagation()
    editController.renderForm($(this))

  $('.goal_block').on 'click', '.edit_form', (e) ->
    e.stopPropagation()

  $('.goal_block').on 'submit', '.edit_form', (e) ->
    e.preventDefault()
    editController.editGoal($(this))

  $('.right_container').on 'click', '.edit', (e) ->
    e.preventDefault()
    e.stopPropagation()
    editController.renderForm($(this))

  $('.right_container').on 'submit', '.edit_form', (e) ->
    e.preventDefault()
    editController.editGoal($(this))




editController =
  renderForm: (link)->
    $li = link.parent()
    liHeight = $li.innerHeight()
    title = $li.find('.title').text().trim()
    desc = $li.find('.description').text().trim()
    klass = $li.data('klass')
    object = $li.data('id')

    $edit_form = $('#orig_edit').clone()
    $edit_form.removeAttr('id')
    $li.html($edit_form)

    titleField = $edit_form.find('.title_field')
    descField = $edit_form.find('.desc_field')
    klassField = $edit_form.find('.klass')
    objectField = $edit_form.find('.object')

    titleField.val(title)
    descField.val(desc)
    klassField.val(klass)
    objectField.val(object)
    if window.innerWidth <= 800
      formHeight = $edit_form.outerHeight()
      editController.expandContainer($edit_form, formHeight, liHeight )
    $edit_form.show()

  editGoal: (form) ->
    data = form.serialize()
    $.ajax '/edit_object',
      method: 'put',
      data: data,
      error: (jqXHR, textStatus, errorThrown) ->
        console.log(errorThrown)
      success: (response, textStatus) ->
        formHeight = form.outerHeight()
        li = form.parent()
        li.html(response)
        liHeight = li.innerHeight()
        editController.collapseContainer(li, formHeight, liHeight)
        form.remove()

  expandContainer: (el, formHeight, liHeight) ->
    goalDiv = el.closest('.goal_block')
    goalHeight = goalDiv.outerHeight()
    goalDiv.animate {
      height: goalHeight - liHeight + formHeight
    }, 200

  collapseContainer: (el, formHeight, liHeight) ->
    goalDiv = el.closest('.goal_block')
    goalHeight = goalDiv.outerHeight()
    goalDiv.animate {
      height: goalHeight - formHeight + liHeight
    }, 200





