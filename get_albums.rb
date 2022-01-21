require "bundler/inline"

gemfile do
  source "https://rubygems.org"
  gem "faraday", require: false
end

# Spotify OAuth token - has no permissions (public only)
@token = "BQC4toi0285Ybg1gbM2Kw7xFVkVkS_jWH6ct3Sz8mg7LMV-3t-Cm8iQaqQIPQiYhxguCoq-ZGktrTyJRsCkKoMTm__k9GCai84NOBGhhWk5lrZ_dFMs50i7SmJjpRUzJrv7vhlbVP0ylq5Hi_J_vUOvfUIY36ZKI_WI4RWj9JvaU2JmqkTSEwPTUxnGMmIqxn2CzXkbV7ko"

require "faraday"
require "cgi"
def connection
  Faraday.new(url: "https://api.spotify.com") do |conn|
    conn.headers["Content-Type"] = "application/json"
    conn.headers["Authorization"] = "Bearer #{@token}"
    conn.adapter Faraday.default_adapter
  end
end

def get_artist_id(artist)
  result = connection.get("/v1/search?query=#{CGI.escape(artist)}&type=artist&offset=0&limit=1")
  items = JSON.parse(result.body).dig("artists", "items")
  items.first["id"]
end

def get_albums(artist, artist_id = nil)
  artist_id ||= get_artist_id(artist)
  result = connection.get("/v1/artists/#{artist_id}/albums?limit=30")
  items = JSON.parse(result.body).dig("items")
  # Return the same array we're putting into the artists file
  items.map { |i| [i["name"], artist, i["total_tracks"], i["release_date"]] }
end

# Write the headers for the csv, because we append after each call
require "csv"
artists = CSV.read("artists.csv").map { |r| r.first }
@album_headers = %i[title artist nbtracks released]
CSV.open("albums.csv", "wb", {col_sep: ";"}) { |csv| csv << @album_headers }

all_albums = []
artists.each do |artist|
  albums = get_albums(artist)
  # Append the artists, so that if there is an error, things don't explode
  CSV.open("albums.csv", "ab", {col_sep: ";"}) { |csv| albums.each { |a| csv << a } }
  all_albums += albums
end

# Honestly, this is just to make it legible for pretty printing, not really required
albums_hash = all_albums.map { |a| @album_headers.zip(a).to_h }
pp albums_hash
pp "Total: Albums: #{all_albums.count}"
