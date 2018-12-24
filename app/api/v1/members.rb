# app/api/v1/albums.rb
module API
  module V1
    class Members < Grape::API
      version 'v1', using: :path, vendor: 'corpu'

      namespace 'bands/:band_name' do
        resources :members do

          desc 'Returns all members'
          get do
            Member.all
          end

          desc "Return a specific member"
          params do
            requires :full_name, type: String
          end
          get ':full_name' do
            Member.find_by(full_name: params[:full_name])
          end

          desc "Create a new member"
          params do
            requires :full_name, type: String
            requires :role, type: String
            requires :alive, type: Boolean
          end
          post do
            Band.find_by(band_name: params[:band_name]) do | band |
              band.members.create!({
                full_name: params[:full_name],
                role: params[:role],
                alive: params[:alive]
              })
            end
          end

          desc "Update a member"
          params do
            requires :full_name, type: String
            requires :role, type: String
            requires :alive, type: Boolean
          end
          put ':full_name' do
            member = Member.find_by(full_name: params[:full_name])
            member.update(role: params[:role], alive: params[:alive])
          end

          desc "Delete a member"
          params do
            requires :full_name, type: String
          end
          delete ':album_name' do
            Album.find_by(full_name: params[:full_name]).destroy
          end
        end
      end
    end
  end
end