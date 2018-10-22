require 'mongoid'

class Album
  include Mongoid::Document

  field :album_name, type: String
  field :year, type: String
  has_many :songs, inverse_of: :album
  belongs_to :band #, inverse_of: :album # optional: true

  validates :album_name, presence: true
  validates :year, presence: true
  validates :band, presence: true

  index({ album_name: 'text' }, { unique: true, name: "album_name_index" })

  #scope :name, -> (name) { where(name: /^#{name}/) }
  scope :year, -> (year) { where(year: year) }
end