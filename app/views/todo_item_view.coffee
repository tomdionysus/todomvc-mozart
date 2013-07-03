class Todo.ItemView extends Mozart.View
  templateName: 'app/templates/todo_item_view'
  tag: 'li'

  init: ->
    super
    @content.bind 'change', @itemChanged
    @bind 'change:completed', @focusOut

  afterRender: =>
    @itemChanged()

  editItem: =>
    @element.addClass('editing')
    @childView('textBox').focus()

  focusOut: (args...) =>
    return unless @element?
    @element.removeClass('editing')
    if @title.length == 0
      @removeItem()
    else
      @save() if @isDirty()

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

  isDirty: =>
    @content.title!=@title or @content.completed!=@completed

  load: =>
    @set 'title', @content.title
    @set 'completed', @content.completed

  save: =>
    @content.set 'title', @title
    @content.set 'completed', @completed
    @content.save()

