class Todo.TodoAppController extends Mozart.Controller

  init: ->
    Todo.TodoItem.loadAllLocalStorage()

    @set 'items', Todo.TodoItem
    @set 'completedfilter', null

    @bind('change:mode',@modeChanged)

    @set 'mode', 'all'

    Todo.TodoItem.bind('change',@itemsChanged)
    @itemsChanged()

  modeChanged: =>
    switch @mode
      when 'completed'
        @set 'completedfilter', 'true'
      when 'active'
        @set 'completedfilter', 'false'
      else
        @set 'completedfilter', ''

  setMode: (mode) =>
    @set 'mode', mode

  itemsChanged: =>
    @set 'displayItems', Todo.TodoItem.count() != 0
    @set 'itemCount', Todo.TodoItem.findByAttribute('completed', false).length
    @set 'completedItemCount', Todo.TodoItem.count() - @itemCount
    @set 'allChecked', @itemCount == 0

  createItem: (name) =>
    return unless name? and name.length>0
    Todo.TodoItem.createFromValues({name:name.trim(), completed: false})
    @itemsChanged()

  clearCompleted: =>
    item.destroy() for item in Todo.TodoItem.all() when item.completed

  setCheckAll: (view, checked) ->
    for item in Todo.TodoItem.all()
      item.set('completed', checked)
      item.save()

      
