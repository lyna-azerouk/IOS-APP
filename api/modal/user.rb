require 'active_record'
require 'jwt'
require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :wallets
  belongs_to :address

  validates :email, :password, :first_name, :last_name, :date_of_birth, :state, presence: true
  validates :email, uniqueness: true

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

  def get_wallets
    formatd_wallets = []

    self.wallets.each do |wallet|
      formatd_wallets << wallet.get_wallet
    end
    formatd_wallets
  end

  def create_verfied_user_dowlla_api
    @dwolla =  Dwolla.new()
    @dwolla.init()

    request_body = {
      :firstName => first_name,
      :lastName => last_name,
      :email => email,
      :type => 'personal',
      :address1 => "adress1",
      :city => address.city,
      :state => address.region,
      :postalCode => address.postal_code,
      :dateOfBirth => date_of_birth,
      :ssn => '1234'
    }

    @dwolla.create_verifed_user(request_body)
  end

  def self.token_expired?(session_token)
    begin
      decoded_token = User.decode(session_token)
      expiration_time = decoded_token[0]['exp']

      expiration_time && Time.at(expiration_time) < Time.now
    rescue JWT::DecodeError => e
      false
    end
  end

  def self.find_user_by_token(session_token)
    decoded_token = User.decode(session_token)
    user_id = decoded_token[0]['user_id']

    user = User.find_by(id: user_id)
    user
  end

  private

  def self.decode(session_token)
    JWT.decode(session_token, "", true, { verify_expiration: true, algorithm: 'HS256' })
  end
end