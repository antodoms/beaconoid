class Beacon < ActiveRecord::Base
  #include Mongoid::Document
  belongs_to :store
  has_many :advertisements
end
