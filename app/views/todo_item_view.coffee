class App.TodoItemView extends Mozart.View
  templateName: 'app/templates/todo_item_view'
  tag: 'li'

  init: ->
    super
    @content.bind 'change', @itemChanged

  afterRender: =>
    if @content.completed
      @element.addClass('completed')

  editItem: =>
    return if @content.completed

    @element.addClass('editing')
    @childView('textBox').focus()

  focusOut: =>
    @element.removeClass('editing')
    @content.save()

  itemChanged: =>
    return unless @content?

    if @content.completed 
      @element.addClass('completed') 
    else
      @element.removeClass('completed')

  removeItem: =>
    @content.destroy()

  checkKey: (e) =>
    @childView('textBox').blur() if e.keyCode == 27 || e.keyCode == 13

