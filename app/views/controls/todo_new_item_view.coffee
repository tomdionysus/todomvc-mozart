class Todo.TodoNewItemView extends Todo.TextControl
  placeholderHtml: 'What needs to be done?'
  autofocusHtml: ''
  id: 'new-todo'

  keyUp: (e) =>
    if e.keyCode == 13
      Todo.todoAppController.createItem(@value)
      @set 'value', null
    else
      super