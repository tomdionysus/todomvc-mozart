Todo.TodoItem = Mozart.Model.create
  modelName: 'TodoItem'

Todo.TodoItem.attributes
  'name': 'string'
  'completed': 'string'

Todo.TodoItem.index 'state'

Todo.TodoItem.localStorage('mozart-todomvc')