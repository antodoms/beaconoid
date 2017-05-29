class GeneralReportChannel < ApplicationCable::Channel

	def subscribed
		stream_from 'beaconoid:general_report'
	end  

end  