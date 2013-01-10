global.ROOT = process.cwd() + "/.app"
global.PROCESS_ENV = process.env.NODE_ENV  || "dev"
global.CONFIG = require "#{ROOT}/config/#{PROCESS_ENV}"
global.MongoBase = require "#{ROOT}/models/mongo_base"
global.Schema    = MongoBase.Schema
global._  = require 'underscore'
global.GAME_CONFIG = require "#{ROOT}/models/game_config"
global.FN = require("#{ROOT}/config/format_notice")
