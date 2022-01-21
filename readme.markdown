# Migrating from Spotify to Apple music

I want to migrate out of Spotify because they don't pay artists well. Apple music is super convenient and [pays artists 2x as much](https://producerhive.com/music-marketing-tips/streaming-royalties-breakdown/) - not as much as Tidal, but it's good enough for me.

I have a lot of favorited artists in Spotify. It's the primarily way I interact with Spotify. Apple music doesn't have favorite artists, so a direct export is impossible.

**NOTE** this is hacky and was designed to solve my specific problem. It probably doesn't solve yours! But it might be useful, so it's here.

### Migration tool

I found [soundiiz](https://soundiiz.com/webapp/playlists) to offer what I needed. I paid 4.50 and it _does_ export artists - but it doesn't import artists into apple music, because apple music doesn't have artists.

So there is a process.

1. use soudiiz to export a list of artists
2. use spotify's API to create a list of the albums
3. use soudiiz to import the albums into spotify

[get_albums.rb](get_albums.rb) is the ruby file that does calls the spotify API to create a list of albums for a given list of artists.

You have to put the artists in a csv file named `artists.csv` (it's gitignored). See [example-artists.csv](example-artists.csv)