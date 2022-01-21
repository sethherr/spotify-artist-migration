require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'faraday', require: false
end

artist = "shamir"

# Spotify OAuth token - has no permissions (public only)
@token = "BQC4toi0285Ybg1gbM2Kw7xFVkVkS_jWH6ct3Sz8mg7LMV-3t-Cm8iQaqQIPQiYhxguCoq-ZGktrTyJRsCkKoMTm__k9GCai84NOBGhhWk5lrZ_dFMs50i7SmJjpRUzJrv7vhlbVP0ylq5Hi_J_vUOvfUIY36ZKI_WI4RWj9JvaU2JmqkTSEwPTUxnGMmIqxn2CzXkbV7ko"

require "faraday"

def connection
  Faraday.new(url: "https://api.spotify.com") do |conn|
    conn.headers["Content-Type"] = "application/json"
    conn.headers["Authorization"] = "Bearer #{@token}"
    conn.adapter Faraday.default_adapter
  end
end

def get_artist_id(artist)
  result = connection.get("/v1/search?query=#{artist}&type=artist&offset=0&limit=1")
  items = JSON.parse(result.body).dig("artists", "items")
  items.first["id"]
end

def get_albums(artist_id)
  result = connection.get("/v1/artists/#{artist_id}/albums?limit=20")
  items = JSON.parse(result.body).dig("items")
  items.map { |i| i["name"] }
end

artist_id = get_artist_id(artist)
albums = get_albums(artist_id)
pp albums
