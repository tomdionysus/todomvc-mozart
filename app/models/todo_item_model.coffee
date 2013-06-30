App.TodoItem = Mozart.Model.create
  modelName: 'TodoItem'

App.TodoItem.attributes
  'name': 'string'
  'completed': 'string'

App.TodoItem.index 'state'