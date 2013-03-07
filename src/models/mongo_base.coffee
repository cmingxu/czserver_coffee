mongoose    = require 'mongoose'
validator   = require 'mongoose-validator'

class MongoBase
  @Schema = mongoose.Schema
  @connection = null
  @validation  = validator.validate
  @connect: ()->
      @connection = mongoose.connect "mongodb://#{CONFIG.mongo_host}/#{CONFIG.mongo_name}", (err) ->
        console.log '[ERROR] connecting to mongodb issue'
        process.exit(0) if err


  @initialize: ()->
    mongoose.model(@name, @schema)

module.exports = MongoBase
