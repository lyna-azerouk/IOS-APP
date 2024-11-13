require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  database: 'ecommerce_development',
  username: 'ecomerce_user',
  password: 'postgres',
  pool: 5
)