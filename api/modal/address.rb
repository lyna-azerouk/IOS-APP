require 'active_record'

class Address < ActiveRecord::Base
  validates :country, :city, :region, :street, :postal_code, presence: true
end