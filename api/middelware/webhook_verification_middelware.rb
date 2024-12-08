require 'openssl'
require 'json'

class WebhookVerificationMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request_body = env['rack.input'].read
    env['rack.input'].rewind
    request_signature = env['HTTP_X_REQUEST_SIGNATURE_SHA_256']

    if !valid_signature?( request_body, request_signature)
      return [401, { 'Content-Type' => 'application/json' }, ['Unauthorized']]
    end
  end

  private

  def valid_signature?(body, signature)
    expected_signature = OpenSSL::HMAC.hexdigest('SHA256', ENV['WEBHOOK_SECRET'], body)
    Rack::Utils.secure_compare(expected_signature, signature)
  end
end