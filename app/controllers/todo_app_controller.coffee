class App.TodoAppController extends Mozart.Controller

  init: ->
    App.TodoItem.createFromValues({name: 'test1', completed: false})
    App.TodoItem.createFromValues({name: 'test1', completed: false})
    App.TodoItem.createFromValues({name: 'test2', completed: true})

  displayAll: =>
    @set 'items', App.TodoItem.all()

  displayActive: =>
    @set 'items', App.TodoItem.findByAttribute('completed', false)

  displayCompleted: =>
    @set 'items', pp.TodoItem.findByAttribute('completed', true)
