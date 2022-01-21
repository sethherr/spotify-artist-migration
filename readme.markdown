# Migrating from Spotify to Apple music

I want to migrate out of Spotify because they don't pay artists well. Apple music is super convenient and [pays artists 2x as much](https://producerhive.com/music-marketing-tips/streaming-royalties-breakdown/) - not as much as Tidal, but it's good enough for me.

I have a lot of favorited artists in Spotify. It's the primarily way I interact with Spotify. Apple music doesn't have favorite artists, so a direct export is impossible.

**NOTE** this is hacky and was designed to solve my specific problem. It probably doesn't solve yours! But it might be useful, so it's here.

### Migration tool

I found [soundiiz](https://soundiiz.com/webapp/playlists) to offer what I needed. I paid 4.50 and it _does_ export artists - but it doesn't import artists into apple music, because apple music doesn't have artists.

So there is a process.

1. Use soudiiz to export a list of artists
2. Use `get_albums.rb` to get all the albums for all the artists
3. Use `separate_albums.rb` to separate out (probable) duplicates and compilations
4. Highly recommended - look at the `albums_processed.csv` in a spreadsheet viewer and quickly review that you aren't adding things you don't want. It's much easier to remove in a spreadsheet tool than 
5. Use soudiiz to import the albums into Spotify. NOTE: the spreadsheet needs to be formatted exactly like the csv that's generated for soundiiz to import it - ie, with `;` separators and columns in the same order.

[get_albums.rb](get_albums.rb) is a ruby file that gets the albums for the given list of artists. It does this via the Spotify API.

[separate_albums.rb](separate_albums.rb) is a ruby file that splits out duplicates and compilations.

You have to put the artists in a csv file named `artists.csv` (it's gitignored). See [example-artists.csv](example-artists.csv)
