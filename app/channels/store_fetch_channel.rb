class StoreFetchChannel < ApplicationCable::Channel

	def subscribed
		stream_from 'beaconoid:store_fetch'
	end  

end  