class ErrorHelper
  @toMongooseError: (type, path) ->
    notice = {}
    notice.message = "Validation failed"
    notice.name    = "ValidationError"
    notice.errors  = {}
    notice.errors[path] = {path: path, type: type}
    notice

  @toFormattedError: (resource, mongooseError) ->
    err = {}
    err["message"] = mongooseError.message
    err["errors"]  = _.pick(_.values(mongooseError.errors)[0], "path", "type")
    err["errors"].resource = resource
    err






module.exports = ErrorHelper
