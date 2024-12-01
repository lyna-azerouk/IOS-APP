require "active_record"
require 'tempfile'

class Document < ActiveRecord::Base

  belongs_to :user
  validates :file_type, presence: true

  def send_to_dwolla
    @dwolla = Dwolla.new()
    @dwolla.init()

    file_path = ""
    file_build = Faraday::UploadIO.new(file_path, 'image/png')

    request_body = {
      :documentType => file_type,
      :file => file_build
    }

    customer_id = user.dwolla_id
    @dwolla.create_document(request_body, customer_id)
  end
end