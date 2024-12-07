require 'sinatra'
require 'openssl'
require 'json'

WEBHOOK_SECRET = 'secret'

post '/webhooks' do
  request_body = request.body.read

  signature = request.env['HTTP_X_REQUEST_SIGNATURE_SHA_256']

  if valid_signature?(request_body, signature)
    event = JSON.parse(request_body)

    handle_event(event)

    status 200
    body 'Webhook received successfully'
  else
    status 403
    body 'Invalid signature'
  end
end

def valid_signature?(body, signature)
  expected_signature = OpenSSL::HMAC.hexdigest('SHA256', WEBHOOK_SECRET, body)
  Rack::Utils.secure_compare(expected_signature, signature)
end

def handle_event(event)
  puts "Received Event: #{event}"
end
