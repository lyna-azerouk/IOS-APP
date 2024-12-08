require_relative '../../modal/user'

module Dwolla
  class CustomerActivatedJob
    include Sidekiq::Worker

    def perform(user_id)
      begin
        user = ::User.find_by(id: user_id )
        user.update!(state: 'verified')
      rescue => e
        puts e.inspect
      end
    end
  end
end