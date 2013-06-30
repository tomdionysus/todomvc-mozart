class App.TodoNewItemView extends App.TextControl
  placeholderHtml: 'What needs to be done?'
  autofocusHtml: ''
  id: 'new-todo'

  keyUp: (e) =>
    if e.keyCode == 13
      App.todoAppController.createItem(@value)
      @set 'value', null
    else
      super