require 'jwt'

payload = { data: 'token', exp: Time.now.to_i + 4 * 3600 }

def encode
  token = JWT.encode( payload, nil, 'HS256')
  puts "Bearcreater #{token}"
end
