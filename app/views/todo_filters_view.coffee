class Todo.TodoFiltersView extends Mozart.View
  templateName: 'app/templates/todo_filters_view'
  tag: 'ul'
  id: 'filters'

  init: ->
    super
    @bind 'change:mode', @modeChanged

  afterRender: =>
    @modeChanged()

  modeChanged: =>
    return unless @element?

    @element.find("a").removeClass('selected')

    switch @mode
      when 'completed'
        @element.find("##{@id}-completed").addClass('selected')
      when 'active'
        @element.find("##{@id}-active").addClass('selected')
      else
        @element.find("##{@id}-all").addClass('selected')
