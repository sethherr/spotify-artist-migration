require "csv"

artists = CSV.read("artists.csv", headers: true).map { |r| r["name"] }

@album_headers = %i[title artist nbtracks released]
albums = CSV.read("albums.csv", {col_sep: ";", headers: true, header_converters: :symbol}).map { |r| r.to_h }

albums_processed = []
albums_pre_processed = []
albums_processed_titles = []
albums_not_artists = []
albums_duplicated = []

albums.each do |album|
  if artists.include?(album[:artist])
    if album[:title].match?(/feat\./i) || album[:title].match?(/remix/i) || album[:title].match?(/Original Score/i)
      albums_not_artists << album
    else
      albums_pre_processed << album
    end
  else
    albums_not_artists << album
  end
end

artists.each do |artist|
  artist_albums = albums_pre_processed.select { |album| album[:artist] == artist }
    .sort_by { |a| a[:title].length }
  unique_titles = []
  artist_albums.each do |album|
    if unique_titles.any? { |t| album[:title].match?(t) }
      albums_duplicated << album
    else
      unique_titles << album[:title]
      albums_processed << album
    end
  end
end

def write_csv(csv_title, array)
  CSV.open("#{csv_title}.csv", "wb", {col_sep: ";"}) do |csv|
    csv << @album_headers
    array.each do |album|
      csv << [album[:title], album[:artist], album[:nbtracks], album[:released]]
    end
  end
end

write_csv("albums_not_artists", albums_not_artists)
write_csv("albums_duplicated", albums_duplicated)
write_csv("albums_processed", albums_processed)

pp "albums_processed: #{albums_processed.count}", "albums_not_artists: #{albums_not_artists.count}", "albums_duplicated: #{albums_duplicated.count}"
