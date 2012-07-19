
express = require 'express'
app = module.exports = express.createServer()

# Configuration.
app.configure ->
  app.set 'views', "#{__dirname}/view"
  app.set 'view engine', 'jade'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.session
    secret: "KioxIqpvdyfMXOHjVkUQmGLwEAtB0SZ9cTuNgaWFJYsbzerCDn"
  app.use app.router
  app.use express.static "#{__dirname}/public"

app.configure 'development', ->
  app.set 'port', 3000
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true

app.configure 'test', ->
  app.set 'port', 3001

# Global Helpers.
require("./apps/helpers") app

# Routes.
require("./apps/home/routes") app

# Listen.
app.listen app.settings.port
console.log "Server listening on port #{app.settings.port} in #{app.settings.env} mode"
