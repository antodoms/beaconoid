class Category < ApplicationRecord


	validates_uniqueness_of :name
	has_many :advertisements

	WillPaginate.per_page = 10

	def search_filter
	  category.try(:name)
	end

	def search_filter=(name)
	  Category.find_by(name: name) if name.present?
	end

	def self.filter_by_name(text)
		where("(LOWER(name) like LOWER(?)) OR (LOWER(description) like LOWER(?))", "%#{text}%", "%#{text}%")
	end

end
