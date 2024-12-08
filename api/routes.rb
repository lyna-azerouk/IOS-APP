require 'sinatra'
require_relative 'controllers/user_controller'
require_relative 'controllers/wallet_controller'
require_relative 'controllers/document_controller'
require_relative 'controllers/webhooks/webhook_controller'
require_relative 'middelware/token_verfication_middelware'
require_relative 'middelware/webhook_verification_middelware'

# use TokenVerificationMiddleware

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

## Document Endpoint
post '/users/:user_id/documents' do
  DocumentController.create(params)
end

get '/users/:user_id/documents' do
  DocumentController.index(params)
end

use WebhookVerificationMiddleware
## WebHooks
post '/webhooks' do
  params = JSON.parse(request.body.read)
  Webhooks::WebhookController.receive(params)
end