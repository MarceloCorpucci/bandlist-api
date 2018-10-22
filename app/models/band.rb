require 'mongoid'

class Band
  include Mongoid::Document

  field :band_name, type: String
  field :genre, type: String
  embeds_many :members
  has_many :albums #, autosave: true, inverse_of: :album_id

  validates :band_name, presence: true
  validates :genre, presence: true

  index({ band_name: 'text' }, { unique: true, name: "band_name_index" })

  #scope :name, -> (name) { where(name: /^#{name}/) }
  #scope :genre, -> (genre) { where(genre: genre) }
end