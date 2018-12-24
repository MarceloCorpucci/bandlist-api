require 'mongoid'

class Band
  include Mongoid::Document
  include Mongoid::Timestamps

  field :band_name, type: String
  field :genre, type: String
  
  has_many :members
  has_many :albums

  validates :band_name, presence: true, uniqueness: true
  validates :genre, presence: true

  index({ band_name: 'text' }, { unique: true, name: "band_name_index" })
end