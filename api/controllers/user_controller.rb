require_relative '../transactions/api/user/save_transaction'
require 'json'
require 'net/https'
require 'uri'


class UserController

  def self.create(params)
    status, message = find_resource(params)
    return [status, message] if status == 401

    transaction = Api::User::SaveTransaction.call(params: params)

    if transaction.success?
      return 200
    else
      return 422, transaction.failure
    end
  end

  def self.login(params)
    user = find_user(params)

    return 404 unless user.present?

    if user.present? && user.eq_password(params['password'])
      return 200
    else
      return 401
    end
  end

  def self.authentificated(params)
    user = find_user(params)

    if user.present? && user.valid_session_token?
      return 200
    else
      return 401
    end
  end

  def self.find_resource(params)
    user = find_user(params)

    if user.present?
      return 401, "Alredy exist"
    end
  end

  def self.find_user(params)
    User.find_by(email: params['email'])
  end
end
