class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  	def validate
		error = ""
		self.errors.full_messages.each do |err|
			error << ((err.present? && error.present?)? "<br>#{err}" : "#{err}")
		end
		error
	end
end
