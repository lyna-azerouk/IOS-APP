require 'sinatra'
require_relative 'controllers/user_controller'
require_relative 'middelware/token_verfication_middelware'

use TokenVerificationMiddleware

get '/' do
  'Hello world!'
end

post '/users/create' do
  params = JSON.parse(request.body.read)

	UserController.create(params)
end

post '/users/login' do
  params = JSON.parse(request.body.read)

	UserController.login(params)
end

get '/users/session_token' do
  params = JSON.parse(request.body.read)

	UserController.authentificated(params)
end