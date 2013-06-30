class App.CheckboxControl extends Mozart.Control
  tag: 'input'
  typeHtml: 'checkbox'
  skipTemplate: true

  init: ->
    super
    @bind 'change:value', @updateValue

  afterRender: =>
    @updateValue()

  updateValue: =>
    return unless @element?
    @element[0].checked = @value

  setValue: ->
    return unless @element?
    @set('value',@element[0].checked)

  change: ->
    @setValue()