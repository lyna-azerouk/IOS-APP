require 'email_address'

module Api
  module Wallet
    class SaveTransaction < BaseTransaction
      tee :params
      step :init_user
      tee :init_wallet
      step :valid_wallet?
      tee :encrypt_card_number
      step :save

      def params(input)
        @params = input.fetch(:params)
      end

      def init_user(input)
        @user = ::User.find_by(id: @params['user_id'])

        if @user.present?
          Success(input)
        else
          Failure(input.merge(errors: {user: "User not found"}))
        end
      end

      def init_wallet(_input)
        @wallet = ::Wallet.new(@params)
        @wallet.user = @user
      end

      def valid_wallet?(input)
        if @wallet.valid?
          Success(input)
        else
          Failure(input.merge(errors: @wallet.errors))
        end
      end

      def encrypt_card_number(_input)
        @wallet.encrypt_number
      end

      def save(input)
        if @wallet.save(validate: false) #Because the card is crypted so it will always fail ==> that why i skip validation after crypting password
          Success(input.merge(wallet: @wallet))
        else
          return Failure(input.merge(errors: @wallet.errors))
        end
      end
    end
  end
end