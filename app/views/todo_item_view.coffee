class Todo.TodoItemView extends Mozart.View
  templateName: 'app/templates/todo_item_view'
  tag: 'li'

  init: ->
    super
    @content.bind 'change', @itemChanged
    @bind 'change:completed', @focusOut
    @load()

  afterRender: =>
    if @content.completed
      @element.addClass('completed')

  editItem: =>
    return if @content.completed

    @element.addClass('editing')
    @childView('textBox').focus()

  focusOut: =>
    return unless @element?
    @element.removeClass('editing')
    @save()

  itemChanged: =>
    return unless @content? and @element?

    @load()

    if @completed 
      @element.addClass('completed') 
    else
      @element.removeClass('completed')

  removeItem: =>
    @content.destroy()

  checkKey: (e) =>
    switch e.keyCode
      when 13
        @childView('textBox').blur()
      when 27
        @load() 
        @childView('textBox').blur()

  load: =>
    @set 'name', @content.name
    @set 'completed', @content.completed

  save: =>
    @content.set 'name', @name
    @content.set 'completed', @completed
    @content.save()

