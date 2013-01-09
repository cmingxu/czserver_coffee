fs = require 'fs'
path = require 'path'

class GameConfig
  @config_path = path.join(ROOT, "config/game_config")
  @_instance = null

  constructor: ()->
    self = this
    fs.readdirSync(GameConfig.config_path).forEach (filename)->
      file_name = path.basename(filename)
      file_name_without_ext = file_name.substring(0, file_name.indexOf("."))
      self[file_name_without_ext] = JSON.parse fs.readFileSync(GameConfig.config_path + "/" + filename)

    self

    

  @instance: ()->
    return GameConfig._instance if GameConfig._instance
    GameConfig._instance = new GameConfig()
    return GameConfig._instance


module.exports = GameConfig.instance()
