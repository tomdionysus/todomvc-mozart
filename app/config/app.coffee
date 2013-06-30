Todo.todoAppController = Todo.TodoAppController.create()

Mozart.root = window

Todo.Application = Mozart.MztObject.create()

Todo.Application.set 'todoAppLayout', Mozart.Layout.create(
  rootElement: '#todoapp'
  states: [
    Mozart.Route.create
      viewClass: Todo.TodoAppView
      path: "/"
      enter: ->
        Todo.todoAppController.set 'mode','all'
        true
    Mozart.Route.create
      viewClass: Todo.TodoAppView
      path: "/active"
      enter: ->
        Todo.todoAppController.set 'mode','active'
        true
    Mozart.Route.create
      viewClass: Todo.TodoAppView
      path: "/completed"
      enter: ->
        Todo.todoAppController.set 'mode','completed'
        true
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
  Todo.Application.todoAppLayout.start()

  Todo.Application.todoInfoLayout.bindRoot()
  Todo.Application.todoInfoLayout.navigateRoute('/')

  $(document).trigger('Mozart:loaded')

$(document).ready(Todo.Application.ready)
    
