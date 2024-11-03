require 'active_record'
require 'jwt'
require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :wallets

  def generate_session_token
    payload = { data: 'user_session_token', exp: Time.now.to_i + 10 * 3600, user_id: self.id }
    self.session_token = JWT.encode(payload, nil, 'HS256')
  end

  def hash_password
    password = Password.create(self.password)
    self.password = password
  end

  def eq_password(password)
    Password.new(self.password) == password
  end

  def self.token_expired?(session_token)
    begin
      decoded_token = User.decode(session_token)
      expiration_time = decoded_token[0]['exp']

      return expiration_time && Time.at(expiration_time) < Time.now
    rescue JWT::DecodeError => e
      return false
    end
  end

  def self.find_user_by_token(session_token)
    decoded_token = User.decode(session_token)
    user_id = decoded_token[0]['user_id']

    user = User.find_by(id: user_id)
    return user
  end

  private

  def self.decode(session_token)
    JWT.decode(session_token, "", true, { verify_expiration: true, algorithm: 'HS256' })
  end
end