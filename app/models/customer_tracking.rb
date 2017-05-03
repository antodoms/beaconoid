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

		scope :fetch, ->{ where(action: "fetch") }
		scope :click, ->{ where(action: "click") }

		scope :fetch_with_store, ->(store){ where(action: "fetch", store_id: store) }
		scope :click_with_store, ->(store){ where(action: "click", store_id: store) }

	elsif Rails.env.production?
		include Dynamoid::Document
		field :customer_id
	  	field :category_id
	  	field :store_id
	  	field :advertisement_id
	  	field :beacon_id
	  	field :action
	  	field :time

		scope :fetch, ->{ where(action: "fetch") }
		scope :click, ->{ where(action: "click") }

		scope :fetch_with_store, ->(store){ where(action: "fetch", store_id: store) }
		scope :click_with_store, ->(store){ where(action: "click", store_id: store) }	  	
	end

	def self.get_json(stores)

		final_data = []
		final_data << ['User Interaction', 'Fetch', 'Click']

		stores.each do |store|
			final_data << [store.name, fetch_with_store(store.id).count, click_with_store(store.id).count]
		end
		final_data
	end


end