class Beacon < ActiveRecord::Base
  #include Mongoid::Document

  validates_uniqueness_of :name

  belongs_to :store
  has_many :advertisements

  #field :name, type: String

end
