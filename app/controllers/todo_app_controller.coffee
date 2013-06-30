class App.TodoAppController extends Mozart.Controller

  init: ->
    App.TodoItem.createFromValues({name: 'test1', completed: false})
    App.TodoItem.createFromValues({name: 'test1', completed: false})
    App.TodoItem.createFromValues({name: 'test2', completed: true})

    @bind('change:mode',@itemsChanged)
    App.TodoItem.bind('change',@itemsChanged)

    @set 'mode', 'all'

  itemsChanged: =>

    switch @mode
      when 'completed'
        @set 'items', App.TodoItem.findByAttribute('completed', true)
      when 'active'
        @set 'items', App.TodoItem.findByAttribute('completed', false)
      else
        @set 'items', App.TodoItem.all()

    @set 'itemCount', App.TodoItem.findByAttribute('completed', false).length
