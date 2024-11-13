require './routes'
require 'dotenv'
Dotenv.load

require './config/database.rb'

run Sinatra::Application
