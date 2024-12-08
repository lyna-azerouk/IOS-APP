require 'dry/transaction'

class BaseTransaction
  include ::Dry::Transaction

  def self.call(*args, &block)
    transaction_result = nil

    ActiveRecord::Base.transaction do
      transaction_result = new.call(*args, &block)

      raise ActiveRecord::Rollback unless transaction_result.failure.nil?
    end
    transaction_result
  end
end