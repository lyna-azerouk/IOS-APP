require './routes'
require 'dotenv'
Dotenv.load
require './config/database.rb'
require_relative "config/shrine"

ShrineSetup.setup
run Sinatra::Application
