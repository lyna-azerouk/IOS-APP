require 'logger'

module Services
  module Dwolla
    class CustomLogger

      def init()
        @logger = Logger.new(STDOUT)
      end

      def log(message, type)
        case type
        when DwollaV2::NotFoundError
          @logger.error(message)

        when DwollaV2::Error
          @logger.error(message)

        when DwollaV2::ExpiredAccessTokenError
          @logger.error(message)

        when DwollaV2::TooManyRequestsError
          @logger.warn(message)

        when DwollaV2::ConflictError
          @logger.debug(message)
        end
      end
    end
  end
end