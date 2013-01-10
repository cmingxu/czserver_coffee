config =
  port: 3000
  mongo_host: "localhost"
  mongo_port: "27017"
  mongo_password: ""
  mongo_name: "czserver_dev"
  loglevel: "dev"
  notice: "en"

  server_list: [
    {name: "localhost", ip: "127.0.0.1", port: 3000}
  ]

module.exports = config
