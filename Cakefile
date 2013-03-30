fs            = require 'fs'
wrench        = require 'wrench'
{print}       = require 'util'
which         = require 'which'
{spawn, exec} = require 'child_process'

# ANSI Terminal Colors
bold  = '\x1B[0;1m'
red   = '\x1B[0;31m'
green = '\x1B[0;32m'
reset = '\x1B[0m'

pkg = JSON.parse fs.readFileSync('./package.json')
testCmd = pkg.scripts.test
startCmd = pkg.scripts.start
  

log = (message, color, explanation) ->
  console.log color + message + reset + ' ' + (explanation or '')

# Compiles app.coffee and src directory to the .app directory
build = (callback) ->
  options = ['-c','-b', '-o', '.app', 'src']
  cmd = which.sync 'coffee'
  coffee = spawn cmd, options
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr
  coffee.on 'exit', (status) -> callback?() if status is 0

# mocha test
test = (callback) ->
  options = [
    '--globals'
    'hasCert,res'
    '--reporter'
    'spec'
    '--compilers'
    'coffee:coffee-script'
    '--colors'
    '--require'
    'should'
    '--require'
    './server'
    './test/models'
    './test/integrations'
  ]
  try
    process.env.NODE_ENV = 'test'
    cmd = which.sync 'mocha' 
    spec = spawn cmd, options
    spec.stdout.pipe process.stdout 
    spec.stderr.pipe process.stderr
    spec.on 'exit', (status) -> callback?() if status is 0
  catch err
    log err.message, red
    log 'Mocha is not installed - try npm install mocha -g', red

task 'docs', 'Generate annotated source code with Docco', ->
  files = wrench.readdirSyncRecursive("src")
  files = ("src/#{file}" for file in files when /\.coffee$/.test file)
  log files
  try
    cmd ='./node_modules/.bin/docco-husky' 
    docco = spawn cmd, files
    docco.stdout.pipe process.stdout
    docco.stderr.pipe process.stderr
    docco.on 'exit', (status) -> callback?() if status is 0
  catch err
    log err.message, red
    log 'Docco is not installed - try npm install docco -g', red

task 'build', ->
  build -> log ":)", green

task 'spec', 'Run Mocha tests', ->
  build -> test -> log ":)", green

task 'test', 'Run Mocha tests', ->
  build -> test -> log ":)", green

task 'dev', 'start dev env', ->
  # watch_coffee
  options = ['-c', '-b', '-w', '-o', '.app', 'src']
  cmd = which.sync 'coffee'  
  coffee = spawn cmd, options
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr
  log 'Watching coffee files', green
  # watch_js
  supervisor = spawn 'node', [
    './node_modules/supervisor/lib/cli-wrapper.js',
    '-w',
    '.app,views', 
    '-e', 
    'js|jade', 
    'server'
  ]
  supervisor.stdout.pipe process.stdout
  supervisor.stderr.pipe process.stderr
  log 'Watching js files and running server', green
  
task 'debug', 'start debug env', ->
  # watch_coffee
  options = ['-c', '-b', '-w', '-o', '.app', 'src']
  cmd = which.sync 'coffee'
  coffee = spawn cmd, options
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr
  log 'Watching coffee files', green
  # run debug mode
  app = spawn 'node', [
    '--debug',
    'server'
  ]
  app.stdout.pipe process.stdout
  app.stderr.pipe process.stderr
  # run node-inspector
  inspector = spawn 'node-inspector'
  inspector.stdout.pipe process.stdout
  inspector.stderr.pipe process.stderr
  # run google chrome
  chrome = spawn 'google-chrome', ['http://0.0.0.0:8080/debug?port=5858']
  chrome.stdout.pipe process.stdout
  chrome.stderr.pipe process.stderr
  log 'Debugging server', green

option '-m', '--model [MODEL]', 'name of model to `scaffold`'
task 'scaffold', 'scaffold model/controller/test', (options) ->
  log "Scaffolding `#{options.model}`", green
  scaffold = require './scaffold'
  scaffold options.model

option '-e', '--env [ENV]', 'dev|test|production'
task 'seeds', 'seed data into db', (options) ->
  cmd = which.sync 'coffee'
  process.env.NODE_ENV = options.env || "test"
  coffee = spawn cmd, ["./scripts/seeds.coffee"]
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr
  coffee.on 'exit', ()->
    process.exit(0)


option "-n", "--name [DBNAME]", "drop a db"
task 'drop', 'drop db', (options) ->
  option = [options.name, "--eval", "db.dropDatabase()"]
  cmd = which.sync 'mongo'
  mongo = spawn cmd, option
  mongo.stdout.pipe process.stdout
  mongo.stderr.pipe process.stderr
  mongo.on 'exit', ()->
    process.exit(0)


task 'export_config', '', (options) ->
  option = ["./scripts/csv_converter.coffee"]
  cmd = which.sync 'coffee'
  coffee = spawn cmd, option
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr
  coffee.on 'exit', ()->
    console.log 'Done'
    process.exit(0)

option "-l", "--email [Email]", "email"
option "-p", "--password [Password]", "password"
task 'generate_account', '', (options) ->
  console.log options.password
  console.log options.email
  unless (options.password or options.email)
    console.log 'set password and email'
    process.exit(1)
  else
    app = require('./.app')
    Admin = require './.app/models/admin'
    u = new Admin({login: options.email, password: options.password})
    u.save (err, o) -> 
      console.log 'Account Inserting Success...' if o
      process.exit(0)

