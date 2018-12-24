# app/api/v1/songs.rb
module API
  module V1
    class Songs < Grape::API
      version 'v1', using: :path, vendor: 'corpu'

      namespace 'bands/:band_name/albums/:album_name' do
        resources :songs do

          desc 'Returns all songs'
          get do
            Song.all
          end

          desc "Return a specific song"
          params do
            requires :title, type: String
          end
          get ':title' do
            Song.find_by(title: params[:title])
          end

          desc "Create a new song"
          params do
            requires :title, type: String
            requires :order, type: Integer
          end
          post do
            Album.find_by(album_name: params[:album_name]) do | album |
              album.songs.create!({
                title: params[:title],
                order: params[:order]
              })
            end
          end

          desc "Update a song"
          params do
            requires :title, type: String
            requires :order, type: String
          end
          put ':title' do
            song = Song.find_by(title: params[:title])
            song.update(order: params[:order])
          end

          desc "Delete a song"
          params do
            requires :title, type: String
          end
          delete ':title' do
            Song.find_by(title: params[:title]).destroy
          end
        end
      end
    end
  end
end