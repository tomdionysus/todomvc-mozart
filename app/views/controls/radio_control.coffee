class App.RadioControl extends Mozart.Control
  tag: 'form'
  skipTemplate: true
  idField: 'id'
  valueField: 'name'

  init: ->
    super
    @bind 'change:value', @updateValue
    @bind 'change:collection', @redraw

  afterRender: =>
    @elements = {}
    for value in @collection
      ele = $('<input>').attr('type','radio').attr('value',value[@idField]).change(@changeChecked)
      @elements[value[@idField]] = ele
      @element.append $('<div>').append(ele).append(value[@valueField])
    @updateValue()

  updateValue: =>
    return unless @element?
    for value, element of @elements
      element[0].checked = @value == value

  changeChecked: (e) =>
    @set 'value', e.target.value
