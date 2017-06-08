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
			store =  Store.find_by(id: store_id)
			if store.present?
				final_data << [store.name, c["count"].to_i,  store_id]
			end
		end
		final_data
	end

	

	def self.group_by_sale(action="with_beacon", time_from=Time.now-1.month, time_to=Time.now, page=1, limit=6)

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

		page = 1
		skip = limit*(page-1)
		if action == "with_beacon"
			store_with_beacon[skip..limit-1]
		elsif action == "without_beacon"
			store_without_beacon[skip..limit-1]
		
		end
				
	end




	def self.group_by_category(action="fetch", time_from=Time.now-1.month, time_to=Time.now, page=1, limit=6)
		final_data = []

		if action == "click"
			ab = self.collection.aggregate([
					{"$match": {"action": action}},
					{"$match": {"time" => {"$gte" => time_from, "$lte" => time_to}}},
					{"$group": {"_id": "$category_id", count: {"$sum" =>  1} }},
					{"$sort": { count: -1 } },
					{"$limit": limit*(page) },
					{"$skip": limit*(page-1) }
					])
			#binding.pry
			ab.each do |c|
				parsed_data = JSON.parse(c["_id"])
				category_id = (parsed_data.is_a? Integer) ? parsed_data : parsed_data.first
				category = Category.find_by(id: category_id)
				if category.present?
					final_data << [category.name, c["count"].to_i,  category_id]
				end
			end
		else
			ab = self.collection.aggregate([
					{"$match": {"action": action}},
					{"$match": {"time" => {"$gte" => time_from, "$lte" => time_to}}},
					{"$group": {"_id": "$beacon_id", count: {"$sum" =>  1} }},
					{"$sort": { count: 1 } }
					])

			final_data = []

			ab.each do |b|
				if Advertisement.find_by_beacon_id(Beacon.find_by(id: b["_id"])) != nil 
					advertisement = Advertisement.find_by(beacon_id: Beacon.find(b["_id"]))
					if advertisement.present?
						category = advertisement.category
						if category.present?
							final_data << [ category.name, b["count"].to_i,  category.id]
						end
					end	
				end
			end
		end

		#binding.pry
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
		if action == "click"
			ab = self.collection.aggregate([
					{"$match": {"action": action} },
					{"$match": {"time" => {"$gte" => time_from, "$lte" => time_to}}},
					{"$group": {"_id": "$category_id", count: {"$sum" =>  1} }},
					{ "$sort": { count: -1 } },
					{ "$count": "count"}
					])
		else
			ab = self.collection.aggregate([
					{"$match": {"action": action} },
					{"$match": {"time" => {"$gte" => time_from, "$lte" => time_to}}},
					{"$group": {"_id": "$category_id", count: {"$sum" =>  1} }},
					{ "$sort": { count: -1 } },
					{ "$count": "count"}
					])
		end
		
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