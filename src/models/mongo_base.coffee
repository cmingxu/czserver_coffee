mongoose = require 'mongoose'

class MongoBase
  @Schema = mongoose.Schema
  @connection = null
  @connect: ()->
    @connection = mongoose.connect "mongodb://#{CONFIG.mongo_host}/#{CONFIG.mongo_name}"


  @initialize: ()->
    return mongoose.model(@name, @schema)

module.exports = MongoBase
