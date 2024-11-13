require 'sidekiq'
require 'sidekiq-cron'
require 'json'
require_relative '../modal/dwolla'
require_relative '../modal/user'

class SetCostumerIdJob
  include Sidekiq::Worker

  def perform
    dwolla = Dwolla.new()
    dwolla.init()
    costumers = dwolla.get_costomers()

    costumers["_embedded"]["customers"].each do |customer|
      user = ::User.find_by(email: customer["email"] )
      user.update(dwolla_id: customer["id"] ) if user.present?
    end
  end
end