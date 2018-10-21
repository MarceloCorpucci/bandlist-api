require "sinatra"
require_relative "../models/album"
require_relative "../serializers/album_serializer"

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

  def album
    @album ||= Album.where(album_name: params[:album_name]).first
  end

  def halt_if_not_found!
    halt(404, { message: 'Album Not Found'}.to_json) unless album
  end

  def serialize(album)
    AlbumSerializer.new(album).to_json
  end
end