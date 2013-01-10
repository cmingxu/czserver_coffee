config =
  port: 80
  mongo_host: "localhost"
  mongo_port: "27017"
  mongo_password: ""
  mongo_name: "czserver_production"
  loglevel: "production"
  notice: "en"

  server_list: [
    {name: "本机", ip: "127.0.0.1", port: 3000}
  ]

module.exports = config
