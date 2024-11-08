require 'sinatra'
require_relative 'controllers/user_controller'
require_relative 'controllers/wallet_controller'
require_relative 'middelware/token_verfication_middelware'

use TokenVerificationMiddleware

get '/' do
  'Hello world!'
end

#User EndPoints
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

#Card EndPoints
post '/users/:user_id/cards' do
  result = params.merge(JSON.parse(request.body.read))
  WalletController.create(result)
end

get '/users/:user_id/cards' do
  result = params.merge(JSON.parse(request.body.read))
  WalletController.index(result)
end

