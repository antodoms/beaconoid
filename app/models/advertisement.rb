class Advertisement < ActiveRecord::Base
  #include Mongoid::Document
  belongs_to :beacon
end
