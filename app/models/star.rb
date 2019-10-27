class Star
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  
  field :hip, type: Integer
  field :hd, type: Integer
  field :hr, type: Integer
  field :gl, type: Integer
  field :bf, type: Integer
  field :proper, type: String
  field :ra, type: Integer
  field :d, type: Integer
  field :dist, type: Integer
  field :pmra, type: Float
  field :pmrd, type: Float
  field :mag, type: Float
  field :absmag, type: Float
  field :classification_id, type: Array
  field :spect, type: Array
  field :ci, type: Float
  field :x, type: Integer
  field :y, type: Float
  field :z, type: Float
  field :vx, type: Float
  field :vy, type: Float
  field :vz, type: Float
  field :constellation_id, type: String
  field :con, type: String
  field :comp, type: Integer
  field :comp_primary, type: Integer
  field :lum, type: Float
  field :var, type: String
  field :var_max, type: Float
  field :var_min, type: Float

  field :_id, type: Integer, default: ->{ hip }
  
  belongs_to :constellation
  has_and_belongs_to_many :classifications
  accepts_nested_attributes_for :constellation, :classifications
  
end
