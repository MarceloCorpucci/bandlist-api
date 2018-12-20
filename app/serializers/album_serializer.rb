require 'pry'

class AlbumSerializer

  def initialize(album)
    @album = album
  end

  def as_json(*)
    data = {
      album_name: @album.album_name,
      year: @album.year
      #band: @album.band
    }
    #binding.pry
    data[:errors] = @album.errors if @album.errors.any?
    data
  end

end