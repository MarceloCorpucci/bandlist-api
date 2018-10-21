class BandSerializer

  def initialize(band)
    @band = band
  end

  def as_json(*)
    data = {
      band_name: @band.band_name,
      genre: @band.genre,
      members: @band.members,
      albums: @band.albums,
      songs: @band.albums.songs
    }
    data[:errors] = @band.errors if @band.errors.any?
    data
  end

end