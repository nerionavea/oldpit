class Remember
	def initialize
		@sms = SMS.new
	end
	def schedule()
		schedule = Rufus::Scheduler.new
		schedule.every '1s' do
			remember_customer(Service.all(:next_change => Time.now.strftime("%Y-%m-%d"), :remembered => false))
		end
	end
	def remember_customer(services)
		services.each do |service|
			@sms = send_remember(services.custmer, service)
			puts 'SMS sended to ' + service.customer.to_s + ' by remember'
			service.update(:remembered => true)
		end
	end
end
