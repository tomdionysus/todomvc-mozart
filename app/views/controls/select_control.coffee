class App.SelectControl extends Mozart.Control
  tag: 'select'
  skipTemplate: true
  idField: 'id'
  valueField: 'name'

  init: ->
    super
    @bind 'change:value', @updateValue
    @bind 'change:collection', @redraw

  afterRender: =>
    @element.empty()
    for value in @collection
      ele = $('<option>').attr('value',value[@idField]).html(value[@valueField])
      @element.append(ele)
    @updateValue()

  updateValue: =>
    return unless @element?
    @element.val(@value)

  setValue: =>
    return unless @element?
    @set 'value', @element.val()

  change: ->
    @setValue()
