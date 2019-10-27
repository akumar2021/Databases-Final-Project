class Supernova
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  
  field :name, type: String
  field :disc_date, type: Date
  field :mmax, type: Integer
  field :ngc_id, type:String
  field :ngc_name, type: String
  field :ra, type: String
  field :d, type: String
  field :type, type: String
  
  belongs_to :ngc
  accepts_nested_attributes_for :ngc
  
end
