require "sinatra"
require "sinatra/namespace"
require_relative "../models/band"
require_relative "../serializers/band_serializer"

namespace '/api/v1' do
  get '/bands' do
    bands = Band.all

    [:name, :genre, :members].each do |filter|
      bands = bands.send(filter, params[filter]) if params[filter]
    end

    bands.map { |band| BandSerializer.new(band) }.to_json
  end

  get '/bands/:name' do |name|
    band = Band.where(name: name).first
    halt_if_not_found!   
    serialize(band)
  end

  post '/bands' do
    band = Band.new(json_params)
    halt 422, serialize(band) unless band.save
    response.headers['Location'] = "#{base_url}/api/v1/bands/#{band.name}"
    status 201
  end

  put '/bands/:name' do |name|
    band = Band.where(name: name).first
    halt_if_not_found!
    halt 422, serialize(band) unless band.update_attributes(json_params)
    serialize(band)
  end

  delete '/bands/:name' do |name|
    band = Band.where(name: name).first
    band.destroy if band
    status 204
  end

end