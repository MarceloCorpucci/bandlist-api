require "sinatra"
require_relative "../models/band"
require_relative "../serializers/band_serializer"

helpers do
  def base_url
    @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
  end

  def json_params
    begin
      JSON.parse(request.body.read)
    rescue
      halt 400, { message: 'Invalid JSON' }.to_json
    end
  end

  def band
    @band ||= Band.where(name: params[:name]).first
  end

  def halt_if_not_found!
    halt(404, { message: 'Band Not Found'}.to_json) unless band
  end

  def serialize(band)
    BandSerializer.new(band).to_json
  end
end