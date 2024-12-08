require 'plaid'

configuration = Plaid::Configuration.new
configuration.server_index = Plaid::Configuration::Environment[ENV['PLAID_ENV'] || 'sandbox']
configuration.api_key['PLAID-CLIENT-ID'] = "672e6abd3e40aa001a0df784"
configuration.api_key['PLAID-SECRET'] = "6ec53acc5eb4cd1b463e9f6f10ae12"
configuration.api_key['Plaid-Version'] = '2020-09-14'

api_client = Plaid::ApiClient.new(
  configuration
)

client = Plaid::PlaidApi.new(api_client)

request = Plaid::UserCreateRequest.new(
  {
    client_user_id: 'c0e2c4ee-b763-4af5-cfe9-46a46bce883d',
    consumer_report_user_identity: {
      first_name: "Carmen",
      last_name: "Berzatto",
      phone_numbers: ["+13125551212"],
      emails: ["carmy@example.com", "bear@example.com"],
      ssn_last_4: "1234",
      date_of_birth: "1987-01-31",
      primary_address: {
        city: "Chicago",
        region: "IL",
        street: "3200 W Armitage Ave",
        postal_code: "60657",
        country: "US"
      }
    }
  }
)
