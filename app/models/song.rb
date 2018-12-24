require 'mongoid'

class Song
  include Mongoid::Document
    
  field :title, type: String
  field :order, type: Integer

  embedded_in :album

  validates :title, presence: true
end