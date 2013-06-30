path = require "path"

module.exports = (grunt) ->
  grunt.registerTask 'testServer', 'Starts the integration server stub', ->
    express = require "express"
    fs = require "fs"
    connectLivereload = require "connect-livereload"
    app = express()

    # Grab configuration options.
    port = grunt.config('testServer.port') || 8010;
    base = path.resolve(grunt.config('testServer.base') || '.');

    GLOBAL.app = app

    app.configure ->
      app.use express.logger(format: "dev")
      app.use express.compress()
      app.use express.bodyParser()
      app.use express.cookieParser()
      app.use express.methodOverride()
      app.use app.router
      app.use connectLivereload({port: 36729})
      app.use express.static(base)
      app.use (req, res) ->
        res.sendfile(base+"/index.html")

    app.configure "development", ->
    app.use express.errorHandler(
      dumpExceptions: true
      showStack: true
    )

    app.configure "production", ->
      app.use express.errorHandler()

    app.listen port
    console.log "Mozart TodoMVC - Express server listening on port #{port}"