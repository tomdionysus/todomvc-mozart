class Todo.ClearCompletedControl extends Mozart.View
  templateName: 'app/templates/controls/todo_clear_completed_control'
  tag: 'button'
  id: "clear-completed"

  init: ->
    super
    @bind 'change:value', @redraw

  beforeRender: =>
    @display = @value!=0

  click: =>
    Todo.appController.clearCompleted()

