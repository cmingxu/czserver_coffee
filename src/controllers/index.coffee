# Just renders index.jade

exports.index = (req, res) ->
  res.format
    html: ()->
      res.render 'index'
    json: ()->
      res.send {index: 'index'}
