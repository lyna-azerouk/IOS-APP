require 'dwolla_v2'

class Dwolla
  @@dwolla = nil

  def init()
    @@dwolla = DwollaV2::Client.new(
    key: "IEo2kvbFJ1mwwHUYqFZ30shh7iZxJ5ATaZiDyEmNgqPtltuQ7T",
    secret: "poOHFUDj1ofcFPsvkGVJeS6uY3AbL4oYkOO7nwXrf2vBsc9Fve",
    environment: :sandbox
    )
  end

  def create_verifed_user(request_body)
    new_customer = @@dwolla.post "customers", request_body
  end
end