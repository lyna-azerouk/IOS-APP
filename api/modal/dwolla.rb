require 'dwolla_v2'

class Dwolla
  @@dwolla = nil

  def init()
    @@dwolla = DwollaV2::Client.new(
    key: ENV['DWOLLA_CLIENT'],
    secret: ENV['DWOLLA_SECRET_KEY'],
    environment: :sandbox
    )
  end

  #costomers
  def create_verifed_user(request_body)
    new_customer = @@dwolla.post "customers", request_body
  end

  def get_costomers
    response_body = @@dwolla.get "customers"
    response_body["_embedded"]["customers"]
  end

  def get_costumer(request_body)
    @@dwolla.get "customers", request_body
  end

  #documents
  def create_document(request_body, customer_id)
   @@dwolla.post "customers/#{customer_id}/documents", request_body
  end
end
