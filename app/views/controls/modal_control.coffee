class App.ModalControl extends Mozart.Control

  afterRender: =>
    @element.hide()

  show: =>
    @element.modal('show')

  hide: =>
    @element.modal('hide')

  ok: ->
    Mozart.getPath(@parent, @target)
    @hide()