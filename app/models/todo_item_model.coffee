Todo.Item = Mozart.Model.create
  modelName: 'TodoItem'

Todo.Item.attributes
  'name': 'string'
  'completed': 'boolean'

Todo.Item.index 'state'

Todo.Item.localStorage()