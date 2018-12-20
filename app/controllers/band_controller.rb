require "sinatra"
require "sinatra/namespace"
require 'pry'
require_relative "../models/band"
require_relative "../serializers/band_serializer"

namespace '/api/v1' do
  get '/bands' do
    bands = Band.all

#    [:band_name, :genre, :members, :albums].each do |filter|
#      bands = bands.send(filter, params[filter]) if params[filter]
#    end

    bands.map { |band| BandSerializer.new(band) }.to_json
  end

  get '/bands/:band_name' do |band_name|
    band = Band.where(band_name: band_name).first
    binding.pry
    #halt_if_not_found!   
    serialize(band)
  end

  post '/bands' do
    band = Band.new(json_params)
    halt 422, serialize(band) unless band.save
    response.headers['Location'] = "#{base_url}/api/v1/bands/#{band.band_name}"
    status 201
  end

  put '/bands/:band_name' do |band_name|
    band = Band.where(band_name: band_name).first
    halt_if_not_found!
    halt 422, serialize(band) unless band.update_attributes(json_params)
    serialize(band)
  end

  delete '/bands/:band_name' do |band_name|
    band = Band.where(band_name: band_name).first
    band.destroy if band
    status 204
  end

end