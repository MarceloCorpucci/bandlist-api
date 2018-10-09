require "sinatra"
require_relative "../models/member"
require_relative "../serializers/member_serializer"

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

  def member
    @member ||= Member.where(full_name: params[:full_name]).first
  end

  def halt_if_not_found!
    halt(404, { message: 'Band member Not Found'}.to_json) unless member
  end

  def serialize(album)
    MemberSerializer.new(member).to_json
  end
end