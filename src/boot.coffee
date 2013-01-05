global.ROOT = process.cwd() + "/.app"
global.PROCESS_ENV = process.env.NODE_ENV  || "dev"
global.CONFIG = require "#{ROOT}/config/#{PROCESS_ENV}"
