require 'active_record'
require 'dry/transaction'
require 'email_address'
require_relative '../../../modal/address'
require_relative '../../../modal/dwolla'
require_relative '../../../modal/user'
require_relative '../../base_transaction'

module Api
  module User
    class SaveTransaction < BaseTransaction

      tee :params
      step :valid_email
      step :init_address
      tee :init_user
      tee :hash_password
      tee :session_token
      step :valid?
      step :save
      step :create_dwolla_user

      def params(input)
        @params = input.fetch(:params)

        @email = @params['email']
        @password = @params['password']
      end

      def valid_email(input)
        is_email_valid = (EmailAddress.new(@email)).valid?

        if is_email_valid
          Success(input)
        else
          Failure(input.merge(errors: {"email": "invalid email"}))
        end
      end

      def init_address(input)
        address = ::Address.new(@params['address'])
        if address.save
          @params['address'] = address
          Success(input)
        else
          Failure(input.merge(errors: address.errors))
        end
      end

      def init_user(_input)
        @user = ::User.new(@params)
      end

      def hash_password(_input)
        @user.hash_password
      end

      def session_token(_input)
        @user.generate_session_token()
      end

      def valid?(input)
       if @user.valid?
        Success(input)
       else
        Failure(input.merge(errors: @user.errors) )
       end
      end

      def save(input)
        if @user.save
          Success(input)
        else
          Failure(errors: @user.errors)
        end
      end

      def create_dwolla_user(input)
        if @user.create_verfied_user_dowlla_api
          Success(input.merge(user: @user))
        else
          Failure(input.merge(errors: "error while creating user in dwolla"))
        end
      end
    end
  end
end