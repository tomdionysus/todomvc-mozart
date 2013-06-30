Todo.todoAppController = Todo.TodoAppController.create()

Mozart.root = window

Todo.Application = Mozart.MztObject.create()

Todo.Application.set 'todoAppLayout', Mozart.Layout.create(
  rootElement: '#todoapp'
  states: [
    Mozart.Route.create
      viewClass: Todo.TodoAppView
      path: "/"
  ]
)

Todo.Application.set 'todoInfoLayout', Mozart.Layout.create(
  rootElement: '#info'
  states: [
    Mozart.Route.create
      viewClass: Todo.TodoInfoView
      path: "/"
  ]
)

Todo.Application.ready = ->
  Todo.Application.set 'domManager', Mozart.DOMManager.create(
    rootElement: 'body'
    layouts: [ 
      Todo.Application.todoAppLayout
      Todo.Application.todoInfoLayout
    ]
  )

  Todo.Application.todoAppLayout.bindRoot()
  Todo.Application.todoAppLayout.navigateRoute('/')

  Todo.Application.todoInfoLayout.bindRoot()
  Todo.Application.todoInfoLayout.navigateRoute('/')

  Todo.Application.set 'router', Mozart.Router.create({useHashRouting: true})

  Todo.Application.router.register('/', Todo.todoAppController.setMode, 'all')
  Todo.Application.router.register('/active', Todo.todoAppController.setMode, 'active')
  Todo.Application.router.register('/completed', Todo.todoAppController.setMode, 'completed')

  Todo.Application.router.start()

  $(document).trigger('Mozart:loaded')

$(document).ready(Todo.Application.ready)
    
