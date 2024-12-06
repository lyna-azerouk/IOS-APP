require "active_record"
require 'tempfile'
require_relative '../uploaders/image_uploader'
require_relative 'services/dwolla/dwolla'

class Document < ActiveRecord::Base
  include ImageUploader::Attachment.new(:file)

  attr_accessor :file
  belongs_to :user

  validates :file_type, presence: true

  def send_to_dwolla
    @dwolla = Services::Dwolla::Dwolla.new
    @dwolla.init

    file_build = Faraday::UploadIO.new(file.path, 'image/png')

    request_body = {
      documentType: file_type,
      file: file_build
    }

    customer_id = user.dwolla_id
    @dwolla.create_document(request_body, customer_id)
  end
end