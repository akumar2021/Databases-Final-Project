class Constellation
  include Mongoid::Document
  field :name, type: String
  field :abbreviation, type: String
  field :origin, type: String
  field :meaning, type: String

  
  has_many :NgcMs
  #has_many :ngcs
  has_many :stars
  accepts_nested_attributes_for :NgcMs, :stars
end
