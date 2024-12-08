require './routes'
require 'dotenv'
Dotenv.load
require './config/database.rb'
require_relative "./config/shrine.rb"

ShrineSetup.setup

Dir[File.join(__dir__, 'modal', '**', '*.rb')].sort.each do |file|
 require file
end

Dir[File.join(__dir__, 'transactions', '**', '*.rb')].sort.each do |file|
  require file
end

run Sinatra::Application
