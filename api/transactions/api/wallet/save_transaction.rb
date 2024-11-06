require 'active_record'
require 'dry/transaction'
require 'email_address'
require_relative '../../../modal/wallet'
require_relative '../../base_transaction'

module Api
  module Wallet
    class SaveTransaction < BaseTransaction
      tee :params
      tee :init_wallet
      step :save

      def params(input)
        @params = input.fetch(:params)
      end

      def init_wallet(_input)
        @wallet = ::Wallet.new(@params)
      end

      def save(input)
        if @wallet.save!
          Success(input.merge(wallet: @wallet))
        else
          return Failure("Invalide wallet")
        end
      end
    end
  end
end