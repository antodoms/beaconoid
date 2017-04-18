class CustomerTracking
	if Rails.env.development?
	    include Mongoid::Document

	  	field :customer_id, type: String
	  	field :category_id, type: String
	  	field :store_id, type: String
	  	field :advertisement_id, type: String
	  	field :beacon_id, type: String
	  	field :action, type: String
	  	field :time, type: String

	elsif Rails.env.production?
		include Dynamoid::Document
		field :customer_id
	  	field :category_id
	  	field :store_id
	  	field :advertisement_id
	  	field :beacon_id
	  	field :action
	  	field :time
	end
end