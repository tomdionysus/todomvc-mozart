Todo.TodoItem = Mozart.Model.create
  modelName: 'TodoItem'

Todo.TodoItem.attributes
  'name': 'string'
  'completed': 'boolean'

Todo.TodoItem.index 'state'

Todo.TodoItem.localStorage()