class Todo.ItemLabelView extends Mozart.View
  skipTemplate: true
  tag: "label"

  init: ->
    super
    @bind('change:value', @itemChanged)

  afterRender: =>
    @itemChanged()

  itemChanged: =>
    return unless @element
    @element.html(@value)

  dblClick: (e) =>
    if @parent.editItem?
      @parent.editItem()


