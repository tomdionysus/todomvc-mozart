class Todo.AppController extends Mozart.Controller

  init: ->
    Todo.Item.loadAllLocalStorage()

    @set 'items', Todo.Item
    @set 'completedfilter', null

    @bind('change:mode',@modeChanged)

    @set 'mode', 'all'

    Todo.Item.bind('change',@itemsChanged)
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
    @set 'displayItems', Todo.Item.count() != 0
    @set 'itemCount', Todo.Item.findByAttribute('completed', false).length
    @set 'completedItemCount', Todo.Item.count() - @itemCount
    @set 'allChecked', @itemCount == 0

  createItem: (title) =>
    return unless title? and title.length>0
    Todo.Item.createFromValues({title: title.trim(), completed: false})
    @itemsChanged()

  clearCompleted: =>
    item.destroy() for item in Todo.Item.all() when item.completed

  setCheckAll: (view, checked) ->
    for item in Todo.Item.all()
      item.set('completed', checked)
      item.save()

      
