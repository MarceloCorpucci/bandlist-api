
# server.rb
require "sinatra"
require "sinatra/namespace"
require "mongoid"
require_relative "models/band"
require_relative "models/member"
require_relative "models/album"
require_relative "serializers/band_serializer"
require_relative "serializers/member_serializer"
require_relative "serializers/album_serializer"
require_relative "helpers/band_helper"
require_relative "helpers/member_helper"
require_relative "helpers/album_helper"
require_relative "controllers/band_controller"
require_relative "controllers/member_controller"
require_relative "controllers/album_controller"

Mongoid.load! "mongoid.config"

namespace '/api/v1' do

  before do
    content_type 'application/json'
  end
  
  get '/' do
    'Welcome to bandlist!'
  end

end





