class Ngc
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  
  field :_id, type: String
  field :name, type: String
  field :alternate_names, type: String
  field :type, type: String
  #field :NgcM_id, type: String
  field :con, type: String
  field :ra, type: String
  field :d, type: String
  field :mag, type: Float
  field :subr, type: Float
  field :size_max, type: String
  field :size_min, type: String
  field :type_class, type: String
  field :brstr, type: String
  field :bchm, type: String
  field :ngc_descr, type: String
  field :notes, type: String
  
  #belongs_to :NgcM
  has_many :supernovas
  #accepts_nested_attributes_for :NgcM, :supernovas
  accepts_nested_attributes_for :supernovas
  
end
