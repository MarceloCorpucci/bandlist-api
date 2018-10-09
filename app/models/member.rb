require 'mongoid'

class Member
  include Mongoid::Document

  field :full_name, type: String
  field :role, type: String
  field :alive, type: Boolean

  embedded_in :band

  validates :full_name, presence: true
  validates :role, presence: true
  validates :alive, presence: true

  #index({ full_name: 'text' }, { unique: true, name: "name_index" })

  #scope :name, -> (name) { where(name: /^#{name}/) }
  #scope :role, -> (role) { where(role: role) }
  #scope :alive, -> (alive) { where(alive: alive) }
end