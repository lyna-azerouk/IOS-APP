require_relative '../modal/response'
require_relative 'api_response_helper'
require_relative '../transactions/api/wallet/save_transaction'
require 'json'
require 'net/https'
require 'uri'

class WalletController

  def self.create(params)
    WalletController.find_user(params)

    if @user.present?
      transaction = Api::Wallet::SaveTransaction.call(params: params)

      if transaction.success?
        wallet = transaction.success[:wallet]
        ApiResponseHelper.render_success(200, wallet.get_wallet)
      else
        ApiResponseHelper.render_failure(422, "unprocessable_entity", transaction.failure[:errors])
      end
    else
      ApiResponseHelper.render_failure(404, "user_not_found")
    end
  end

  def self.index(params)
    WalletController.find_user(params)

    if @user.present?
      user_wallets = @user.get_wallets
      ApiResponseHelper.render_success(200, user_wallets)
    else
      ApiResponseHelper.render_failure(404, "user_not_found")
    end
  end

  def self.find_user(params)
    @user = User.find_by(id: params['user_id'])
    @user
  end
end