# Define the namespace.
window.Todo = @Todo = Todo = {}

# Setup Logging.
Todo.log = (status) ->
  console.log("LOG:", status) if console?

Todo.warn = (status) ->
  console.log("WARNING:", status) if console?

Todo.title = (title) ->
  window.title = title if window?