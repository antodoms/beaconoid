class CustomerTracking
	# if Rails.env.development?
	    include Mongoid::Document

	  	field :customer_id, type: String
	  	field :category_id, type: String
	  	field :store_id, type: String
	  	field :advertisement_id, type: String
	  	field :beacon_id, type: String
	  	field :action, type: String
	  	field :time, type: String

	# elsif Rails.env.production?
	# 	include Dynamoid::Document
	# 	field :customer_id
	#   	field :category_id
	#   	field :store_id
	#   	field :advertisement_id
	#   	field :beacon_id
	#   	field :action
	#   	field :time	
	# end


  	def self.fetch
  		where(action: "fetch").all
  	end

  	def self.click
  		where(action: "click").all
  	end

  	def self.fetch_with_store(store)
  		where(action: "fetch", store_id: store).all
  	end

  	def self.click_with_store(store)
		where(action: "click", store_id: store).all
	end	

	def self.group_by_store_click
		final_data = []
		#binding.pry
		ab = self.collection.aggregate([
				{"$match": {"action": "click"}},
				{"$group": {"_id": "$store_id", count: {"$sum" =>  1} }},
				{ "$sort": { count: -1 } },
				{ "$limit": 6 }
				])

		final_data = []
		ab.each do |c|
			store_id = c["_id"].to_i
			final_data << [ Store.find_by(id: store_id).name, c["count"].to_i ]
		end
		final_data
	end

	def self.group_by_store_fetch
		final_data = []
		ab = self.collection.aggregate([
				{"$match": {"action": "fetch"} },
				{"$group": {"_id": "$store_id", count: {"$sum" =>  1} }},
				{ "$sort": { count: -1 } },
				{ "$limit": 6 }
				])
		final_data = []
		ab.each do |c|
			store_id = c["_id"].to_i
			final_data << [ Store.find_by(id: store_id).name, c["count"].to_i ]
		end
		final_data
	end

	def self.get_json(stores)

		final_data = []

		stores.each do |store|
			final_data << [store.name, fetch_with_store(store.id).count]
		end
		final_data
	end


end