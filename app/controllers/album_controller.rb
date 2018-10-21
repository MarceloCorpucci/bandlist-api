require "sinatra"
require "sinatra/namespace"
require_relative "../models/album"
require_relative "../serializers/album_serializer"

namespace '/api/v1' do
  get '/albums' do
    albums = Album.all

    [:name, :year, :songs].each do |filter|
      albums = albums.send(filter, params[filter]) if params[filter]
    end

    albums.map { |album| AlbumSerializer.new(album) }.to_json
  end

  get '/albums/:album_name' do |album_name|
    album = Album.where(album_name: album_name).first
    halt_if_not_found!   
    serialize(album)
  end

  post '/albums' do
    album = Album.new(json_params)
    halt 422, serialize(album) unless album.save
    response.headers['Location'] = "#{base_url}/api/v1/albums/#{album.album_name}"
    status 201
  end

  put '/albums/:album_name' do |album_name|
    album = Album.where(album_name: album_name).first
    halt_if_not_found!
    halt 422, serialize(album) unless album.update_attributes(json_params)
    serialize(album)
  end

  delete '/albums/:album_name' do |album_name|
    album = Album.where(album_name: album_name).first
    album.destroy if album
    status 204
  end

end