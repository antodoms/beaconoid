class Advertisement < ActiveRecord::Base
  #include Mongoid::Document
  belongs_to :beacon

  belongs_to :category
end
