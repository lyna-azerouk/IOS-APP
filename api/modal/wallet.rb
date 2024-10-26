require 'active_record'

class wallet < ActiveRecord::Base
  belongs_to :user
end