require 'active_record'

class User < ActiveRecord::Base
  has_many :wallets
end