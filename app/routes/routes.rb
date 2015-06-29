
get '/' do
	redirect to ('/index')
end

get '/index' do
	haml :index
end

get '/checkcustomer' do
    haml :checkci
end

post '/create_service' do
	@customer = Customer.find_or_send_new_customer_form(params[:placa])
	haml :form_service
end

get '/listservice' do
	@customer = Customer.all
	@Services = Service.all
	haml :listservice
end

post '/service' do
	@servic = Service.create_service(params[:customer], params[:service])
	sms = SMS.new()
	sms.thanks_customer(params[:customer],@servic)
	haml :ticket
end

get '/service/:id' do
	@servic = Service.get(params[:id])
	haml :show_service
end
get '/service/:id/ticket' do
	@servic = Service.get(params[:id])
	haml :ticket
end

get '/customer' do
	@customer = Customer.all
	haml :listcustomer
end

get '/customer/:id' do
	@customer = Customer.get(params[:id])
	haml :show_customer
end

get '/customer/:id/edit' do
	@customer = Customer.get(params[:id])
	haml :edit_customer
end

put '/customer/:id/edit' do
	customer = Customer.get(params[:id])
	customer.update(params[:customer])
	redirect to ('/customer')
end 


post '/find' do
	customer = Customer.first(:placa => params[:placa])
	if customer != nil
		redirect to("/customer/#{customer.id}")
	else
		@errortitulo = "No Encontrado"
		@errordetalle = "Disculpe, no se ha encontrado ningun cliente registrado que posea esa cedula de identidad #{params[:placa]}, por favor verifique."
		haml :error
	end
end


