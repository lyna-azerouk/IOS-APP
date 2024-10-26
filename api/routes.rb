require 'sinatra'
require_relative 'controllers/user_controller'

get '/' do
  'Hello world!'
end

post '/users' do
  params = JSON.parse(request.body.read)

	UserController.create(params)
end
