# app/api/v1/albums.rb
module API
  module V1
    class Albums < Grape::API
      version 'v1', using: :path, vendor: 'corpu'

      namespace 'bands/:band_name' do
        resources :albums do

          desc 'Returns all albums'
          get do
            Album.all
          end

          desc "Return a specific album"
          params do
            requires :album_name, type: String
          end
          get ':album_name' do
            Album.find_by(album_name: params[:album_name])
          end

          desc "Create a new album"
          params do
            requires :album_name, type: String
            requires :year, type: String
          end
          post do
            Band.find_by(band_name: params[:band_name]) do | band |
              band.albums.create!({
                album_name: params[:album_name],
                year: params[:year]
              })
            end
          end

          desc "Update an album"
          params do
            requires :album_name, type: String
            requires :year, type: String
          end
          put ':album_name' do
            album = Album.find_by(album_name: params[:album_name])
            album.update(year: params[:year])
          end

          desc "Delete an album"
          params do
            requires :album_name, type: String
          end
          delete ':album_name' do
            Album.find_by(album_name: params[:album_name]).destroy
          end
        end
      end
    end
  end
end