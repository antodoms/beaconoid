class CustomerTracking
	# if Rails.env.development?
	    include Mongoid::Document

	  	field :customer_id, type: String
	  	field :category_id, type: String
	  	field :store_id, type: String
	  	field :advertisement_id, type: String
	  	field :beacon_id, type: String
	  	field :action, type: String
	  	field :time, type: DateTime

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

	def self.group_by_store_click(page=0, limit=6)
		final_data = []

		ab = self.collection.aggregate([
				{"$match": {"action": "click"}},
				{"$match": {"time" => {"$gte" => Time.now-1.month, "$lte" => Time.now}}},
				{"$group": {"_id": "$store_id", count: {"$sum" =>  1} }},
				{ "$sort": { count: -1 } },
				{ "$limit": limit },
				{ "$store_id": { "$lt": "<50th store_id>" } }
				])

		final_data = []
		ab.each do |c|
			store_id = c["_id"].to_i
			final_data << [ Store.find_by(id: store_id).name, c["count"].to_i,  store_id]
		end
		final_data
	end

	def self.group_by_store_fetch(page=0, limit=6)
		final_data = []
		ab = self.collection.aggregate([
				{"$match": {"action": "fetch"} },
				{"$match": {"time" => {"$gte" => Time.now-1.month, "$lte" => Time.now}}},
				{"$group": {"_id": "$store_id", count: {"$sum" =>  1} }},
				{ "$sort": { count: -1 } },
				{ "$limit": limit },
				{ "$skip": (page) }
				])
		final_data = []
		ab.each do |c|
			store_id = c["_id"].to_i
			final_data << [ Store.find_by(id: store_id).name, c["count"].to_i , store_id]
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