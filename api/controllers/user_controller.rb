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

  def self.find_resource(params)
    user = User.find_by(email: params['email'])

    if user.present?
      return 401, "Alredy exist"
    end
  end
end
