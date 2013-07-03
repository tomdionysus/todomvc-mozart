Todo.appController = Todo.AppController.create()

Mozart.root = window

Todo.Application = Mozart.MztObject.create()

Todo.Application.set 'appLayout', Mozart.Layout.create(
  rootElement: '#todoapp'
  states: [
    Mozart.Route.create
      viewClass: Todo.AppView
      path: "/"
  ]
)

Todo.Application.set 'infoLayout', Mozart.Layout.create(
  rootElement: '#info'
  states: [
    Mozart.Route.create
      viewClass: Todo.InfoView
      path: "/"
  ]
)

Todo.Application.ready = ->
  Todo.Application.set 'domManager', Mozart.DOMManager.create(
    rootElement: 'body'
    layouts: [ 
      Todo.Application.appLayout
      Todo.Application.infoLayout
    ]
  )

  Todo.Application.appLayout.bindRoot()
  Todo.Application.appLayout.navigateRoute('/')

  Todo.Application.infoLayout.bindRoot()
  Todo.Application.infoLayout.navigateRoute('/')

  Todo.Application.set 'router', Mozart.Router.create({useHashRouting: true})

  Todo.Application.router.register('/', Todo.appController.setMode, 'all')
  Todo.Application.router.register('/active', Todo.appController.setMode, 'active')
  Todo.Application.router.register('/completed', Todo.appController.setMode, 'completed')

  Todo.Application.router.start()

  $(document).trigger('Mozart:loaded')

$(document).ready(Todo.Application.ready)
    
