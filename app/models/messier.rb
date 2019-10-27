class Messier
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  
  field :name, type: String
  #field :NgcM_id, type: String
  field :ngc_name, type: String
  field :con, type: String
  field :ra, type: String
  field :d, type: String
  field :mag, type: Float
  field :type, type: String
  field :notes, type: String
  
  field :_id, type: Integer, default: ->{ name }
  
  #belongs_to :NgcM
  #accepts_nested_attributes_for :NgcM
  
end
