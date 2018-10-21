require "sinatra"
require_relative "../models/song"
require_relative "../serializers/song_serializer"

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

  def song
    @song ||= Song.where(song_title: params[:song_title]).first
  end

  def halt_if_not_found!
    halt(404, { message: 'Song Not Found'}.to_json) unless song
  end

  def serialize(song)
    SongSerializer.new(song).to_json
  end
end