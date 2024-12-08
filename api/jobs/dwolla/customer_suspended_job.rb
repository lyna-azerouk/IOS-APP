require_relative '../../modal/user'

module Dwolla
  class CustomerSuspendeddJob
    include Sidekiq::Worker

    def perform(user_id)
      begin
        user = ::User.find_by(id: user_id )
        user.update!(state: 'suspended')
      rescue => e
        puts e.inspect
      end
    end
  end
end