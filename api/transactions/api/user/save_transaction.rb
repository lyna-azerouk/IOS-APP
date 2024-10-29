require 'active_record'
require 'dry/transaction'
require 'email_address'
require_relative '../../../modal/user'
require_relative '../../base_transaction'

module Api
  module User
    class SaveTransaction < BaseTransaction

      tee :params
      step :valid_email
      tee :init_user
      tee :hash_password
      tee :session_token
      step :valid?
      step :save

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
          Failure("Invalid email format")
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
        Failure( "Invalid")
       end
      end

      def save(input)
        if @user.save
          Success(input)
        else
          Failure("Erreur lors du téléchargment")
        end
      end
    end
  end
end