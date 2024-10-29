require_relative '../transactions/api/user/save_transaction'
require_relative '../modal/response'
require 'json'
require 'net/https'
require 'uri'

class UserController

  def self.create(params)
    status, message = find_resource(params)
    return [status, message] if status == 401

    transaction = Api::User::SaveTransaction.call(params: params)

    if transaction.success?
      response = Response.new()
      response.init_success({data: transaction.success[:user], code: 200})
      return 200, response.as_json
    else
      response = Response.new()
      response.init_success({ code: 422, errors: transaction.failure})
      return 422, response.as_json
    end
  end

  def self.login(params)
    user = find_user(params)

    return 404 unless user.present?

    if user.present? && user.eq_password(params['password'])
      response = Response.new()
      response.init_success({data: @user, code: 200})
      return 200, response.as_json
    else
      return 401
    end
  end

  def self.authentificated(params)
    user = find_user(params)

    if user.present? && user.valid_session_token?
      response = Response.new()
      response.init_success({data:@user, code: 200})
      return 200, response.as_json
    else
      return 401
    end
  end

  def self.find_resource(params)
    find_user(params)

    if @user.present?
      return 401, "Alredy exist"
    end
  end

  def self.find_user(params)
    @user = User.find_by(email: params['email'])
    @user
  end
end
