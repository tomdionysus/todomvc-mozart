# Define the namespace.
window.App = @App = App = {}

# Setup Logging.
App.log = (status) ->
  console.log("LOG:", status) if console?

App.warn = (status) ->
  console.log("WARNING:", status) if console?

App.title = (title) ->
  window.title = title if window?