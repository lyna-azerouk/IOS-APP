require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  database: ENV['DATA_BASE_NAME'],
  username: ENV['DATA_BASE_USER'],
  password: ENV['DATA_BASE_PASSWORD'],
  pool: 5
)