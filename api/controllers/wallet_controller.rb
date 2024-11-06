require_relative '../modal/response'
require_relative 'api_response_helper'
require_relative '../transactions/api/wallet/save_transaction'
require 'json'
require 'net/https'
require 'uri'

class WalletController

  def self.create(params)
    transaction = Api::Wallet::SaveTransaction.call(params: params)

    if transaction.success?
      return 200
    else
      retrun 422
    end
  end
end