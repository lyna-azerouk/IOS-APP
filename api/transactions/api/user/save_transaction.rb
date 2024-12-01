require 'active_record'
require 'dry/transaction'
require 'email_address'
require_relative '../../../modal/address'
require_relative '../../../modal/controller'
require_relative '../../../modal/dwolla'
require_relative '../../../modal/user'
require_relative '../../../modal/business_user'
require_relative '../../base_transaction'

module Api
  module User
    class SaveTransaction < BaseTransaction

      tee :params
      step :valid_email
      step :init_address
      step :maybe_init_controller
      step :init_user
      tee :hash_password
      tee :session_token
      step :valid?
      step :save
      step :create_dwolla_user

      def params(input)
        @params = input.fetch(:params)

        @email = @params['email']
        @password = @params['password']
        @params = build_params
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
        address = ::Address.new(@params['user']['address'])

        if address.save
          @params['user']['address'] = address
          Success(input)
        else
          Failure(input.merge(errors: address.errors))
        end
      end

      def maybe_init_controller(input)
        return Success(input) if @params['user']['business_type'] == "soleProprietorship"

        if !@params['user']['controller'].nil?
          @params['user']['controller']['address'] = ::Address.new(@params['user']['controller']['address'])
          controller = ::Controller.new(@params['user']['controller'])

          if controller.save
            @params['user']['controller'] = controller
            Success(input)
          else
            Failure(input.merge(errors: controller.errors))
          end
        else
          Failure(input.merge(errors: {"controller": "conroller is blank"}))
        end
      end

      def init_user(input)
        case @params['user']['user_type']
        when "personal"
          @user = ::User.new(@params['user'])
        when "business"
          @user = ::BusinessUser.new(@params['user'])
        else
          return Failure(input.merge(errors:{"type": "Incorrect type"}))
        end

        Success(input)
      rescue => e
        return Failure(input.merge(errors:{"type": "Incorrect type"}))
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
        if @user.save && (@bs_user.nil? || @bs_user.save)
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

      private

      def build_params
       @params.merge!("state" => "verified")
       users_keys = @params.keys - buisness_keys()

       case @params['user_type']
       when "personal"
          {"user" => @params.slice(*users_keys)}
       when "business"
          {"user" => buisness_params()}
       end
      end

      def buisness_keys
        case @params['business_type']
        when "soleProprietorship"
          %w[business_type business_name ein business_classification user]
        else
          %w[business_type business_name ein business_classification user controller]
        end
      end

      def buisness_params
        case @params['business_type']
        when "soleProprietorship"
          params_keys = @params.keys
          @params.slice(*(params_keys - ["controller"]))
        else
          @params
        end
      end
    end
  end
end