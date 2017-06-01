class Category < ApplicationRecord


	validates_uniqueness_of :name
	has_many :advertisements

	default_scope { order(created_at: :desc) }

	WillPaginate.per_page = 10

	def self.filter_by_name(text)
		where("(LOWER(name) like LOWER(?)) OR (LOWER(description) like LOWER(?))", "%#{text}%", "%#{text}%")
	end

end
