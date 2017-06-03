class Store < ActiveRecord::Base
	validates_uniqueness_of :name
	has_many :beacons


	def self.filter_by_name(text)
		where("(LOWER(name) like LOWER(?))", "%#{text}%")
	end


end

WillPaginate.per_page = 10
