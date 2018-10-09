# server.rb
require "sinatra"
require "sinatra/namespace"
require "mongoid"
require_relative "models/member"
require_relative "serializers/member_serializer"
require_relative "helpers/member_helper"
require_relative "controllers/member_controller"
require_relative "models/band"
require_relative "serializers/band_serializer"
require_relative "helpers/band_helper"
require_relative "controllers/band_controller"

Mongoid.load! "mongoid.config"

namespace '/api/v1' do

  before do
    content_type 'application/json'
  end
  
  get '/' do
    'Welcome to bandlist!'
  end

end





