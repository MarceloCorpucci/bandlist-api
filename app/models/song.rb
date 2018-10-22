require 'mongoid'

class Song
  include Mongoid::Document

  field :song_title, type: String
  field :acoustic, type: Boolean
  #embedded_in :album
  belongs_to :album, inverse_of: :song

  validates :song_title, presence: true

  index({ song_title: 'text' }, { unique: true, name: "song_title_index" })

  scope :song_title, -> (song_title) { where(song_title: /^#{song_title}/) }
end