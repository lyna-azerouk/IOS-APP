require 'active_record'

class Controller < ActiveRecord::Base

  belongs_to :address

  validates :first_name, :last_name, :title, :date_of_birth, :ssn,  presence: true
end