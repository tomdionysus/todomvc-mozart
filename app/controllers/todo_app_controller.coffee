class App.TodoAppController extends Mozart.Controller

  init: ->
    App.TodoItem.loadAllLocalStorage()

    @set 'items', App.TodoItem

    @bind('change:mode',@itemsChanged)
    
    @set 'mode', 'all'
    @set 'completedfilter', null

    App.TodoItem.bind('change',@fixCounts)
    @fixCounts()

  itemsChanged: =>

    switch @mode
      when 'completed'
        @set 'completedfilter', 'true'
      when 'active'
        @set 'completedfilter', 'false'
      else
        @set 'completedfilter', ''

  displayAll: => @set 'mode','all'
  displayActive: => @set 'mode','active'
  displayCompleted: => @set 'mode','completed'

  fixCounts: =>
    @set 'displayItems', App.TodoItem.count() != 0
    @set 'itemCount', App.TodoItem.findByAttribute('completed', false).length
    @set 'completedItemCount', App.TodoItem.count() - @itemCount

  createItem: (name) =>
    App.TodoItem.createFromValues({name:name, completed: false})
    @fixCounts()

  clearCompleted: =>
    item.destroy() for item in App.TodoItem.all() when item.completed
      
