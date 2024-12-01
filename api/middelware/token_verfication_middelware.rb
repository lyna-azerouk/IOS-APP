require 'jwt'

class TokenVerificationMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    bearer_token = env['HTTP_AUTHORIZATION']

    if bearer_token.nil? || bearer_token.empty?
      return [401, { 'Content-Type' => 'application/json' }, ['Unauthorized']]
    end

    begin
      decode(bearer_token)
    rescue JWT::DecodeError => e
      return [401, { 'Content-Type' => 'application/json' }, ['Invalid Token']]
    end

    @app.call(env)
  end


  private
  def decode(bearer_token)
    token = bearer_token.split(' ').last()
    JWT.decode(token, "", true, { verify_expiration: true, algorithm: 'HS256' })
  end
end