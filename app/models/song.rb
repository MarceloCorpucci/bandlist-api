require 'mongoid'

class Song
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :role, type: String
  field :alive, type: Boolean

  belongs_to :band

  validates :full_name, presence: true, uniqueness: true
  validates :role, presence: true
  validates :alive, presence: true

  index({ full_name: 'text' }, { unique: true, name: "name_index" })
end