class Todo.NewItemControl extends Todo.TextControl
  placeholderHtml: i18n.todo.whatNeedsDone()
  autofocusHtml: ''
  id: 'new-todo'

  keyUp: (e) =>
    if e.keyCode == 13
      Todo.appController.createItem(@value)
      @set 'value', null
    else
      super