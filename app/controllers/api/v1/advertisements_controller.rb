class Api::V1::AdvertisementsController < ActionController::API

	class AdvertisementNotFound < StandardError; end
	class BeaconNotFound < StandardError; end

	def index
		begin
			if params[:email].present? && params[:beacon_id].present?
				new_customer = 0
				customer = Customer.find_by(:email => params[:email])
				if !customer.present?
					customer = Customer.create(:email => params[:email])
					new_customer = 1
				end
				beacon = Beacon.find_by(:unique_reference => params[:beacon_id])
				if !beacon.present?
					raise BeaconNotFound
				end
				advertisements = beacon.advertisements
				
				CustomerTracking.create(customer_id: customer.id, category_id: advertisements.pluck(:category_id), store_id: beacon.store_id, advertisement_id: advertisements.pluck(:id), beacon_id: beacon.id, action: "fetch", time: Time.now)
				#binding.pry

		        ActionCable.server.broadcast 'beaconoid:store_fetch',
		            message: beacon.store_id,
		            user: customer.id

		        ActionCable.server.broadcast 'beaconoid:general_report',
		            message: [new_customer,1,0,0,0,0],
		            user: customer.id

				render json: modify(advertisements)
			elsif params[:email].present? && params[:advertisement_id].present?
				new_customer = 0
				customer = Customer.find_by(:email => params[:email])
				if !customer.present?
					customer = Customer.create(:email => params[:email])
					new_customer = 1
				end
				advertisement = Advertisement.find_by(id: params[:advertisement_id])
				if !advertisement.present?
					raise AdvertisementNotFound
				end

				beacon = advertisement.beacon

				CustomerTracking.create(customer_id: customer.id, category_id: [advertisement.category_id], store_id: beacon.store_id, advertisement_id: [advertisement.id], beacon_id: beacon.id, action: "click", time: Time.now)

				ActionCable.server.broadcast 'beaconoid:store_click',
		            message: beacon.store_id,
		            user: customer.id

		        ActionCable.server.broadcast 'beaconoid:general_report',
		            message: [new_customer,0,1,0,0,0],
		            user: customer.id

				render json: {status: :success}
			else
				#binding.pry
				render json: {status: :failed, reason: "please pass the right parameters"}
			end
		rescue BeaconNotFound
			render json: {status: :failed, reason: "beacon not found"}
		rescue AdvertisementNotFound
			render json: {status: :failed, reason: "advertisement not found"}
		end
	end

	def modify(ads)
		{
			:status => :success,
			:advertisements => gen_ads(ads)
		}

	end

	def gen_ads(ads)
		final_ads = []
		ads.each do |ad|
			final_ads << {
				:id => ad.id,
				:name => ad.name,
				:beacon_id => ad.beacon_id,
				:category_id => ad.category_id,
				:description => ad.description,
				:created_at => ad.created_at,
				:updated_at => ad.updated_at,
				:price => ad.price,
				:image => "https:"+ad.image.url(:medium)
			}
		end
		final_ads
	end


end
