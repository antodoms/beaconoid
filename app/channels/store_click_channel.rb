class StoreClickChannel < ApplicationCable::Channel

	def subscribed
		stream_from 'beaconoid:store_click'
	end  

end  