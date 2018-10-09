require 'mongoid'

class Band
  include Mongoid::Document

  field :name, type: String
  field :genre, type: String
  embeds_many :members

  validates :name, presence: true
  validates :genre, presence: true

  index({ name: 'text' }, { unique: true, name: "name_index" })

  #scope :name, -> (name) { where(name: /^#{name}/) }
  #scope :genre, -> (genre) { where(genre: genre) }
end