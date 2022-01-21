# Migrating from Spotify to Apple music

I want to migrate out of Spotify because they don't pay artists well. Apple music is super convenient and [pays artists 2x as much](https://producerhive.com/music-marketing-tips/streaming-royalties-breakdown/) - not as much as Tidal, but it's good enough for me.

I have a lot of favorited artists in Spotify. It's the primarily way I interact with Spotify. Apple music doesn't have favorite artists, so a direct export is impossible.

### Migration tools

- [streamexport.com](http://www.streamexport.com/spotify_exports) - didn't export artists

- [SpotMyBackup](https://github.com/secuvera/SpotMyBackup) - doesn't export artists

- [soundiiz](https://soundiiz.com/webapp/playlists) - seems promising - paid 4.50 and it _does_ export artists - but it doesn't import artists into apple music, because apple music doesn't have artists. So I have a csv of artists! However, because the export import functionality doesn't work, I don't think it's worth paying for this.

### Get the list of artists from Spotify

Go to Spotify in chrome, view your artists, open up the developer tools, select the `<div id="main">...</div>`, right click and `copy` > `copy element`

<img width="50%" alt="Screen Shot copy spotify artists" src="screenshot-copy-spotify-artists.png">

Relevant HTML:

```html
<button data-testid="play-button" aria-label="Play Shamir" class="Button-qlcn5g-0 kNOYsX"><div class="ButtonInner-sc-14ud5tc-0 cSeieV encore-bright-accent-set"><span aria-hidden="true" class="IconWrapper__Wrapper-sc-1hf1hjl-0 jWeDTW"><svg role="img" height="24" width="24" viewBox="0 0 24 24" class="Svg-sc-1bi12j5-0 hDgDGI"><path d="M6 21l15.589-9L6 3z"></path></svg></span></div></button></div></div><div class="E1N1ByPFWo4AJLHovIBQ"><a draggable="false" title="Shamir" class="Nqa6Cw3RkDMV8QnYreTr" dir="auto" href="/artist/7JgXEHI1oEiQICAMeCsKTj"><div class="nk6UgB4GUYNoAcPtAQaG JSkXrK3CXFYeDgTW8iHv" as="div">Shamir</div></a><div class="Za_uNH8nTZ0qCuIqbPLZ Hi9FqPX1LNRRPf31tfA8" as="div" style="color: rgb(179, 179, 179);"><span>Artist</span></div></div><div class="tsv7E_RBBw6v0XTQlcRo" data-testid="card-click-handler"></div></div></div><div class="LunqxlFIupJw_Dkx6mNx"><div class="XiVwj5uoqqSFpS4cYOC6" draggable="true"><div class="xBV4XgMq0gC5lQICFWY_"><div class="g4PZpjkqEh5g7xDpCr2K yYflTYbufy7rATGQiZfq"><div class=""><img aria-hidden="false" draggable="false" loading="lazy" src="https://i.scdn.co/image/455a70605e44303c96a4438012598e5ac0260d58" data-testid="card-image" alt="" class="mMx2LUixlnN_Fu45JpFB SKJSok3LfyedjZjujmFt yYflTYbufy7rATGQiZfq"></div></div><div class="woJQ5t2YiaJhjTv_KE7p">
```

Use some regex to get the artists names from that HTML.

... I'm not sure this makes sense to do, I think soudiiz might make sense to pay for because it offers import into apple music

### Get list of artists

[Musicbrainz API](https://musicbrainz.org/doc/MusicBrainz_API) - but actually, that does

https://musicbrainz.org/ws/2/