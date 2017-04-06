class Beacon < ActiveRecord::Base
  #include Mongoid::Document
  has_many :advertisement
end
