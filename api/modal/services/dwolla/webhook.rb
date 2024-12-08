
require 'dwolla_v2'
require 'sidekiq'
require_relative '../../../jobs/dwolla/customer_activated_job'
require_relative '../../../jobs/dwolla/customer_desactivated_job'
require_relative '../../../jobs/dwolla/customer_suspended_job'

module Services
  module Dwolla
    class Webhook

      attr_accessor :topic, :user

      def initialize(topic:, user:)
        @topic = topic
        @user = user
      end

      def handel_event
        case topic
        when 'customer_activated'
          ::Dwolla::CustomerActivatedJob.perform_async(@user.id)

        when 'customer_deactivated'
          ::Dwolla::CustomerDesactivatedJob.perform_async(@user.id)

        when 'customer_suspended'
          ::Dwolla::CustomerSuspendeddJob.perform_async(@user.id)

        when 'transfer_completed'

        else
          nil
        end
      end
    end
  end
end