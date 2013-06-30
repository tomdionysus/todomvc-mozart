App.todoAppController = App.TodoAppController.create()

Mozart.root = window

App.Application = Mozart.MztObject.create()

App.Application.set 'todoAppLayout', Mozart.Layout.create(
  rootElement: '#todoapp'
  states: [
    Mozart.Route.create
      viewClass: App.TodoAppView
      path: "/"
      enter: ->
        App.todoAppController.displayAll()
        true
    Mozart.Route.create
      viewClass: App.TodoAppView
      path: "/active"
      enter: ->
        App.todoAppController.displayActive()
        true
    Mozart.Route.create
      viewClass: App.TodoAppView
      path: "/completed"
      enter: ->
        App.todoAppController.displayCompleted()
        true
  ]
)

App.Application.set 'todoInfoLayout', Mozart.Layout.create(
  rootElement: '#info'
  states: [
    Mozart.Route.create
      viewClass: App.TodoInfoView
      path: "/"
  ]
)

App.Application.ready = ->
  App.Application.set 'domManager', Mozart.DOMManager.create(
    rootElement: 'body'
    layouts: [ 
      App.Application.todoAppLayout
      App.Application.todoInfoLayout
    ]
  )

  App.Application.todoAppLayout.bindRoot()
  App.Application.todoAppLayout.start()

  App.Application.todoInfoLayout.bindRoot()
  App.Application.todoInfoLayout.navigateRoute('/')

  $(document).trigger('Mozart:loaded')

$(document).ready(App.Application.ready)
    
