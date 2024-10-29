require 'active_record'
require 'jwt'
require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :wallets

  def generate_session_token
    payload = { data: 'user_session_token', exp: Time.now.to_i + 10 * 60}
    self.session_token = JWT.encode(payload, nil, 'HS256')
  end

  def hash_password
    password = Password.create(self.password)
    self.password = password
  end

  def eq_password(password)
    Password.new(self.password) == password
  end

  def valid_session_token?
    begin
      decoded_token = decode
      expiration_time = decoded_token[0]['exp']

      return expiration_time && Time.at(expiration_time) > Time.now
    rescue JWT::DecodeError => e
      return false
    end
  end

  private

  def decode
    JWT.decode(session_token, "", true, { verify_expiration: true, algorithm: 'HS256' })
  end
end