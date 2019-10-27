class NgcM
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  
  field :ngc_id, type: Integer
  field :messier_id, type: Integer
  field :constellation_id, type: Integer
  
  belongs_to :constellation
  has_many :ngcs
  has_many :messiers
  accepts_nested_attributes_for :constellation, :ngcs, :messiers
end
