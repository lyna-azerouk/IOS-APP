require 'dwolla_v2'
require_relative 'custom_logger'

module Services
  module Dwolla
    class Dwolla
      @@dwolla = nil

      def init()
        @@dwolla = DwollaV2::Client.new(
          key: ENV['DWOLLA_CLIENT'],
          secret: ENV['DWOLLA_SECRET_KEY'],
          environment: :sandbox
        )

        @logger = Services::Dwolla::CustomLogger.new()
      end

      #costomers
      def create_verifed_user(request_body)
        new_customer = @@dwolla.post "customers", request_body
      end

      def get_costomers
        response_body = @@dwolla.get "customers"
        response_body["_embedded"]["customers"]
      end

      def get_costumer(request_body)
        @@dwolla.get "customers", request_body
      end

      #documents
      def create_document(request_body, customer_id)
        begin
          @@dwolla.post "customers/#{customer_id}/documents", request_body

        rescue => e
          @logger.log(e.message, e.class)
        end
      end
    end
  end
end
