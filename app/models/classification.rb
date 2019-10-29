class Classification
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :name, type: String
  
  field :_id, type: Integer, default: ->{ name }
  
  has_and_belongs_to_many :stars
  accepts_nested_attributes_for :stars
end
