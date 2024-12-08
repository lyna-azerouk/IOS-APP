require_relative '../../modal/user'

module Dwolla
  class CustomerDesactivatedJob
    include Sidekiq::Worker

    def perform(user_id)
      begin
        user = ::User.find_by(id: user_id )
        user.update!(state: 'deactivated')
      rescue => e
        puts e.inspect
      end
    end
  end
end