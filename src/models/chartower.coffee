class Chartower extends MongoBase
  @schema = @Schema(
    someField: String
  )

module.exports = Chartower.initialize()
