# application.rb
require "grape"
require "mongoid"

Mongoid.load! "mongoid.config"

Dir["#{File.dirname(__FILE__)}/app/models/**/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/app/api/**/*.rb"].each { |f| require f }

module API
  class Root < Grape::API
    format :json
    prefix :api

    get :status do
      { status: 'ok' }
    end
    
    mount V1::Bands
    mount V1::Albums
    mount V1::Members
    mount V1::Songs
  end
end

BandList = Rack::Builder.new {

  map "/" do
    run API::Root
  end

}





