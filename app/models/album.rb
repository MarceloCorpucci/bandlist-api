require 'mongoid'

class Album
  include Mongoid::Document
  include Mongoid::Timestamps

  field :album_name, type: String
  field :year, type: String
  
  belongs_to :band

  validates :album_name, presence: true
  validates :year, presence: true
end