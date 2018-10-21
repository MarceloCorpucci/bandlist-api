class AlbumSerializer

  def initialize(album)
    @album = album
  end

  def as_json(*)
    data = {
      album_name: @album.album_name,
      year: @album.year,
      songs: @album.songs
    }
    data[:errors] = @album.errors if @album.errors.any?
    data
  end

end