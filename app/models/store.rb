class Store
	
	if Rails.env.development?

	    include Mongoid::Document
	    field :name, type: String
  		field :code, type: String

	elsif Rails.env.production?

		include Dynamoid::Document
	  	field :name
  		field :code

	end
 
end