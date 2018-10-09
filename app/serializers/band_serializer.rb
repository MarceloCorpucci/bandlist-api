class BandSerializer

  def initialize(band)
    @band = band
  end

  def as_json(*)
    data = {
      name: @band.name,
      genre: @band.genre,
      members: @band.members
    }
    data[:errors] = @band.errors if @band.errors.any?
    data
  end

end