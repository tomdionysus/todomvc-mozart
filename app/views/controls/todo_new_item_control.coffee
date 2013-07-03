class Todo.NewItemControl extends Todo.TextControl
  placeholderHtml: 'What needs to be done?'
  autofocusHtml: ''
  id: 'new-todo'

  keyUp: (e) =>
    if e.keyCode == 13
      Todo.appController.createItem(@value)
      @set 'value', null
    else
      super