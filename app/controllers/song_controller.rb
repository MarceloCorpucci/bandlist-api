require "sinatra"
require "sinatra/namespace"
require_relative "../models/song"
require_relative "../serializers/song_serializer"

namespace '/api/v1' do
  get '/songs' do
    songs = Song.all

    [:song_title, :acoustic].each do |filter|
      song = song.send(filter, params[filter]) if params[filter]
    end

    song.map { |song| SongSerializer.new(song) }.to_json
  end

  get '/songs/:song_title' do |song_title|
    song = Song.where(song_title: song_title).first
    halt_if_not_found!
    serialize(song)
  end

end