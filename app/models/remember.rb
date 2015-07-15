class Remember
	def initialize
		@sms = SMS.new
	end
	def schedule()
		schedule = Rufus::Scheduler.new
		schedule.every '10s' do
			send_customer_remembers()
		end
	end
	def send_customer_remembers()
		services = Service.all()
		services.each do |service|
			if service.next_change.to_s == Time.now.strftime("%Y-%m-%d") && service.remembered == false
				@sms.send_remember(service.customer, service)
				service.update(:remembered => true)
			end
		end
	end
end
