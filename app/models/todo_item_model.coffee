Todo.Item = Mozart.Model.create
  modelName: 'TodoItem'

Todo.Item.attributes
  'title': 'string'
  'completed': 'boolean'

Todo.Item.index 'completed'

Todo.Item.localStorage
  prefix: 'todos-mozart'