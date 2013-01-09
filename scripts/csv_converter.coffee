fs  = require 'fs'
csv = require 'csv'
path= require 'path'
_   = require 'underscore'
mkdirp = require 'mkdirp'

csv_file_path = path.join(__dirname,"..", "docs/design_docs/csv_data")
export_path   = path.join(__dirname,"..", ".app/config/game_config")
console.log export_path
mkdirp.sync export_path, "777"

convert = (file_path)->
  config = {}
  config.content = []
  file_name = path.basename(file_path)
  file_name_without_ext = file_name.substring(0, file_name.indexOf("."))

  to_file = export_path + "/" + file_name_without_ext + ".json"

  csv().from.stream(fs.createReadStream(file_path))
    .to.path(to_file)
    .on('end', ()->  fs.writeFileSync(to_file, JSON.stringify config))
    .on('record', (record, index)->
      config.attrs = record if index == 0 
      config.chinese_name = record if index == 1
      config.type = record if index == 2

      item = {}
      if index > 2
        for att, index in record
          item[config.attrs[index]]  = att
        config.content.push item

    )



csv_files = fs.readdirSync csv_file_path
csv_files.forEach (file_name)->
  file_path = csv_file_path + "/" + file_name
  if path.extname(file_path) == ".csv"
    convert file_path
