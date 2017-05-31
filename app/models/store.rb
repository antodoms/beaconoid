class Store < ActiveRecord::Base
	validates_uniqueness_of :name
	has_many :beacons



	def self.filter_by_store_name(text)
		where(name: text)
	end

	def self.filter_by_store_id(text)
		where(id: text)
	end

	def self.filter_by_store_code(text)
		where(unique_id: text)
	end
	
	def self.sales(text)
	end


end

WillPaginate.per_page = 10
