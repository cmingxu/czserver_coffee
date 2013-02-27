Admin = require '../models/admin'

# Admin model's CRUD controller.
module.exports = 

  # Lists all admins
  index: (req, res) ->
    Admin.find {}, (err, admins) ->
      res.format
        html: ()->
          res.render "admins/index", admins
        json: ()->
          res.send admins

  # new admin 
  new: (req, res) ->
    admin = new Admin
      
  # Creates new admin with data from `req.body`
  create: (req, res) ->
    admin = new Admin req.body
    admin.save (err, admin) ->
      if not err
        res.send admin
        res.statusCode = 201
      else
        res.send ErrorHelper.toFormattedError(admin, err)
        res.statusCode = 422
        
  # Gets admin by id
  show: (req, res) ->
    Admin.findById req.params.admin, (err, admin) ->
      if not err
        res.send admin
      else
        res.send err
             
  # Updates admin with data from `req.body`
  update: (req, res) ->
    Admin.findById req.params.admin, (err, admin) ->
      if not err
        _.extend(admin, req.body)
        admin.save(err, admin) ->
          if not err
            res.send admin 
          else
            res.send ErrorHelper.toFormattedError("admin", err)
            res.statusCode = 422
      else
        res.statusCode = 404
    
  # Deletes admin by id
  destroy: (req, res) ->
    Admin.findByIdAndRemove req.params.admin, (err) ->
      if not err
        res.send {}
      else
        res.send err
      
  
