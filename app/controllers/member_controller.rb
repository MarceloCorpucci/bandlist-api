require "sinatra"
require "sinatra/namespace"
require_relative "../models/member"
require_relative "../serializers/member_serializer"

namespace '/api/v1' do
  get '/members' do
    members = Member.all

    [:name, :role, :alive].each do |filter|
      member = member.send(filter, params[filter]) if params[filter]
    end

    member.map { |member| MemberSerializer.new(member) }.to_json
  end

  get '/members/:name' do |name|
    member = Member.where(name: name).first
    halt_if_not_found!
    serialize(member)
  end

  #post '/albums' do
  #  album = Album.new(json_params)
  #  halt 422, serialize(album) unless album.save
  #  response.headers['Location'] = "#{base_url}/api/v1/albums/#{album.name}"
  #  status 201
  #end

  #patch '/albums/:name' do |name|
  #  album = Album.where(name: name).first
  #  halt_if_not_found!
  #  halt 422, serialize(album) unless album.update_attributes(json_params)
  #  serialize(album)
  #end

  #delete '/albums/:name' do |name|
  #  album = Album.where(name: name).first
  #  album.destroy if album
  #  status 204
  #end

end