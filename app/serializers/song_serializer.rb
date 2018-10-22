class SongSerializer

  def initialize(song)
    @song = song
  end

  def as_json(*)
    data = {
      song_title: @song.song_title,
      acoustic: @song.acoustic,
      album: @song.album
    }
    data[:errors] = @song.errors if @song.errors.any?
    data
  end

end