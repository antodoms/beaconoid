class Store < ActiveRecord::Base
	validates_uniqueness_of :name
	has_many :beacons
end
