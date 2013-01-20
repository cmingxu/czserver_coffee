module.exports =

  # Lists all uniqservers
  index: (req, res) ->
    res.send CONFIG.server_list

  create: (req, res) ->
    uniqserver = new uniqserver req.body
    uniqserver.save (err, uniqserver) ->
      if not err
        res.send uniqserver
        res.statusCode = 201
      else
        res.send ErrorHelper.toFormattedError("uniqserver", err)
        res.statusCode = 422
