class Category < ApplicationRecord

	validates_uniqueness_of :name
	has_many :advertisements

	def self.filter_by_id(text)
		where(id: text)
	end

	def self.filter_by_category_name(text)
		where(name: text)
	end

	def self.filter_by_description(text)
		where(description: text)
	end


end

WillPaginate.per_page = 10
