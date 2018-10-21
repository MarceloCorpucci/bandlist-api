require 'mongoid'

class Song
  include Mongoid::Document

  field :song_title, type: String
  field :acoustic, type: Boolean
  embedded_in :album

  validates :song_title, presence: true

  #index({ name: 'text' }, { unique: true, name: "name_index" })

  #scope :name, -> (name) { where(name: /^#{name}/) }
end