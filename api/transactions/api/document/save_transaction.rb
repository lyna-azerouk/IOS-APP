require_relative '../../base_transaction'

module Api
  module Document
    class SaveTransaction < BaseTransaction

      tee :params
      step :veried_user?
      tee :init_document
      step :valid?
      step :save
      tee :send_to_dwolla

      def params(input)
        @params = input.fetch(:params)
        @params = @params.without("user_id")
      end

      def veried_user?(input)
        @user = @params['user']

        if @user.state == "verified"
          Success(input)
        else
          Failure(input.merge(errors: {"user_type": "user is not verfied"}))
        end
      end

      def init_document(input)
        @document = ::Document.new(
          name: @params['file']['filename'],
          file_type: @params['file_type'],
          user: @params['user'],
          file_data: @params['file'],
          file: @params['file']['tempfile']
        )
      end

      def valid?(input)
        if @document.valid?
          Success(input)
        else
          Failure(input.merge(errors: @document.errors))
        end
      end

      def save(input)
        if @document.save!
          Success(input.merge(document: @document))
        else
          Failure(input.merge(errors: @document.errors))
        end
      end

      def send_to_dwolla(_input)
        if @document.present?
          @document.send_to_dwolla()
        end
      end
    end
  end
end