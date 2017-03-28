class Store
	
	if Rails.env.development?
	    include Mongoid::Document
	elsif Rails.env.production?
		include Dynamoid::Document
	end
  
  	field :name, type: String
  	field :code, type: String
end