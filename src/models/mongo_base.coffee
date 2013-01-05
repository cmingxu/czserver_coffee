mongoose = require 'mongoose'

class MongoBase
  @Schema = mongoose.Schema
  @connect: ()->
    mongoose.connect "mongodb://#{CONFIG.mongo_host}/#{CONFIG.mongo_name}"

  @initialize: ()->
    mongoose.model(@name, @schema)

module.exports = MongoBase
