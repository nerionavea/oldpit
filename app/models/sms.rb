class SMS
	def initialize()
		@client = Savon.client(wsdl: 'http://200.41.57.109:8086/m4.in.wsint/services/M4WSIntSR?wsdl')
	end
	def thanks_customer(params_customer, service)
		customer= Customer.first(:placa => params_customer[:placa])
		message = "EL SULTAN DE LOS ACEITES, le informa a #{customer.nombre} que su proximo cambio de aceite de su #{service.vehiculo} es a los #{service.kilsig} con el #{service.oil}"
		send_sms(customer.telefono, message)
		send_info(customer.telefono)
	end
	def send_info(to)
		send_sms(to, "EL SULTAN DE LOS ACEITES, Horario de trabajo Lun-Vie 7Am-6Pm Sab 7Am-4Pm Dom 7Am-12Pm Tel. 0261-7540167, Instagram @elsultandelosaceites")
	end
	def send_remember(customer, service)
		message = "EL SULTAN DE LOS ACEITES Te recuerda #{customer.nombre}, haz tu cambio, cuida tu motor, te recomendamos hacerlo antes de que cumpla los #{service.kilsig}Kms "
		send_sms(customer.telefono, message)
	end
	private
	def send_sms(to,text)
		@client.call(:send_sms, message: {
		'passport' => 'VXSMC', 
		'password' => 'gs8naf6ra2', 
		'number' => convert_number_to_international(to), 
		'text' => text})	
	end
	def convert_number_to_international(number)
		'58' + number[-10..10]
	end
end