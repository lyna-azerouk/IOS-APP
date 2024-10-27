require 'sinatra'
require_relative 'controllers/user_controller'
require_relative 'middelware/token_verfication_middelware'

use TokenVerificationMiddleware

get '/' do
  'Hello world!'
end

post '/users' do
  puts "%%%%%%"
  params = JSON.parse(request.body.read)

	UserController.create(params)
end
