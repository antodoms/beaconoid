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



	def self.group_by_store(action="click", time_from=Time.now-1.month, time_to=Time.now, page=1, limit=6)
		final_data = []

		ab = self.collection.aggregate([
				{"$match": {"action": action}},
				{"$match": {"time" => {"$gte" => time_from, "$lte" => time_to}}},
				{"$group": {"_id": "$store_id", count: {"$sum" =>  1} }},
				{"$sort": { count: -1 } },
				{"$limit": limit*(page) },
				{"$skip": limit*(page-1) }
				])

		final_data = []
		ab.each do |c|
			store_id = c["_id"].to_i
			final_data << [ Store.find_by(id: store_id).name, c["count"].to_i,  store_id]
		end
		final_data
	end

	def self.group_by_sale(action="click")
		final_data = []

		ab = self.collection.aggregate([
				{"$group": {"_id": "$store_id" }}				
				])

		store_with_beacon = []
		store_without_beacon = []
		Store.all.each do |s|
			flag = false
			store_id = s["_id"].to_i

			Beacon.all.each do |b|

				if b.store_id == s.id
					store_with_beacon << [ s.name, s.sales, s.id]
					flag = true
				end

			end
			
			store_id = s["_id"].to_i
			if flag == false
				store_without_beacon << [ s.name, s.sales, s.id]
			end
			flag = false
		end

		if action == "click"
			store_with_beacon
		elsif action == "fetch"
			store_without_beacon
		end
				
	end




	def self.group_by_category(action="fetch", time_from=Time.now-1.month, time_to=Time.now, page=1, limit=6)
		final_data = []

		ab = self.collection.aggregate([
				{"$match": {"action": action}},
				{"$match": {"time" => {"$gte" => time_from, "$lte" => time_to}}},
				{"$group": {"_id": "$beacon_id", count: {"$sum" =>  1} }},
				{"$sort": { count: 1 } }
				])

		final_data = []


		ab.each do |b|
			if Advertisement.find_by_beacon_id(Beacon.find_by(id: b["_id"])) != nil
				beacon_id = Advertisement.find_by_beacon_id(Beacon.find(b["_id"])).category_id		
				final_data << [ Category.find(beacon_id).name, b["count"].to_i,  Category.find(beacon_id).id]
			end
		end
		
		final_data
	end


	def self.group_by_store_count( action="click", time_from=Time.now-1.month, time_to=Time.now, limit=6)
		ab = self.collection.aggregate([
				{"$match": {"action": action} },
				{"$match": {"time" => {"$gte" => time_from, "$lte" => time_to}}},
				{"$group": {"_id": "$store_id", count: {"$sum" =>  1} }},
				{ "$sort": { count: -1 } },
				{ "$count": "count"}
				])
		
		#binding.pry
		count = ab.first["count"] if ab.first.present?
		count/limit if count.present?
	end

	def self.group_by_category_count( action="click", time_from=Time.now-1.month, time_to=Time.now, limit=6)
		ab = self.collection.aggregate([
				{"$match": {"action": action} },
				{"$match": {"time" => {"$gte" => time_from, "$lte" => time_to}}},
				{"$group": {"_id": "$category_id", count: {"$sum" =>  1} }},
				{ "$sort": { count: -1 } },
				{ "$count": "count"}
				])
		
		#binding.pry
		count = ab.first["count"] if ab.first.present?
		count/limit if count.present?
	end	


	def self.get_json(stores)

		final_data = []

		stores.each do |store|
			final_data << [store.name, fetch_with_store(store.id).count]
		end
		final_data
	end


end