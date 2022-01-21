require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'faraday', require: false
end

artist = "shamir"

# Spotify OAuth token - has no permissions (public only)
token = "BQC4toi0285Ybg1gbM2Kw7xFVkVkS_jWH6ct3Sz8mg7LMV-3t-Cm8iQaqQIPQiYhxguCoq-ZGktrTyJRsCkKoMTm__k9GCai84NOBGhhWk5lrZ_dFMs50i7SmJjpRUzJrv7vhlbVP0ylq5Hi_J_vUOvfUIY36ZKI_WI4RWj9JvaU2JmqkTSEwPTUxnGMmIqxn2CzXkbV7ko"

require 'faraday/net_http'
Faraday.default_adapter = :net_http

def connection
  Faraday.new(url: "https://api.spotify.com") do |conn|
    conn.headers["Content-Type"] = "application/json"
    conn.headers["Authorization"] = "Bearer #{token}"
    conn.adapter Faraday.default_adapter
  end
end

result = connection.get("/v1/search?query=#{artist}&type=artist&offset=0&limit=1")

pp JSON.parse(result.body)

# curl -X "GET" "https://api.spotify.com/v1/search?q=#{artist}&type=artist" -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer BQCGAjlvJsRiLHWEPMyb9HXA0vR3-QjJpM7diLFvQbTONlm4bYKtJC3kFxLqmBHZZfhgF3_8Q7DchNqWDlZ_ajhkDR6CRKG6ethQ4jKFa5YQ3TVT9F7UvC8EX-rzAW862ziRKPlwAUVQYkUmFNJr7DWZAT2j-sFcf9A1z4Ld9lC3pAcyZYdsSjamVlJ9lXsb-Ug2LpeZS4g"
# response = HTTParty.get("https://api.spotify.com/v1/search?q=#{artist}&type=artist")