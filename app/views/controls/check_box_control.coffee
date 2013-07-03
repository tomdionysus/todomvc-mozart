class Todo.CheckboxControl extends Mozart.Control
  tag: 'input'
  typeHtml: 'checkbox'
  skipTemplate: true

  init: ->
    super
    @bind 'change:value', @updateValue

    # Considering making this available for all views in 0.1.9
    if @checkAction
      [target, method] = Mozart.parsePath(@checkAction)
      if target?
        target = Mozart.getPath(@parent,target)
      else
        target = @parent
      @bind('check', (data) =>
        target[method](@, data)
      )

  afterRender: =>
    @updateValue()

  updateValue: =>
    return unless @element?
    @element[0].checked = @value

  setValue: ->
    return unless @element?
    @trigger('check',@element[0].checked)
    @set('value', @element[0].checked)

  change: ->
    @setValue()