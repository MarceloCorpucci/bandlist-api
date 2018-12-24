# app/api/v1/bands.rb
module API
  module V1
    class Bands < Grape::API
      version 'v1', using: :path, vendor: 'corpu'

      resources :bands do

        desc 'Returns all bands'
        get do
          Band.all
        end

        desc "Return a specific band"
        params do
          requires :band_name, type: String
        end
        get ':band_name' do
          Band.find(params[:band_name])
        end

        desc "Create a new band"
        params do
          requires :band_name, type: String
          requires :genre, type: String
        end
        post do
          Band.create!(band_name: params[:band_name],
                       genre: params[:genre])
        end

        desc "Update a band"
        params do
          requires :band_name, type: String
          requires :genre, type: String
        end
        put ':band_name' do
          band = Band.find(params[:band_name])
          band.update(genre: params[:genre])
        end

        desc "Delete a band"
        params do
          requires :band_name, type: String
        end
        delete ':band_name' do
          Band.find(params[:band_name]).destroy
        end

      end
    end
  end
end