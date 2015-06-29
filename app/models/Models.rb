class Customer
	include DataMapper::Resource
	property :id, Serial
	property :nombre, String
	property :placa, String
	property :telefono, String
	property :email, String
	has n, :services

	def self.find_or_create_customer(customer)
		self.first_or_create({:placa => customer[:placa]}, customer)
	end

	def self.find_or_send_new_customer_form(placa)
		if customer_exist?(placa)
			self.first(:placa => placa)
		else
			EmptyCustomer.new(placa)
		end
	end

	def self.customer_exist?(placa)
		self.first(:placa => placa) != nil
	end
end

EmptyCustomer = Struct.new(:placa, :nombre, :email, :telefono)

class Service
	include DataMapper::Resource
	property :id, Serial
	property :fecha, Date
	property :oil, String
	property :kilact, String
	property :kilsig, String
	property :vehiculo, String
	property :next_change, Date
	property :remembered, Boolean, :default => false
	belongs_to :customer

	def self.create_service(customer, service)
		service[:fecha] = Time.now
		service[:next_change] = Time.now + 30.days
		Customer.find_or_create_customer(customer).services.create(service)
	end
end

class UserConfig
	include DataMapper::Resource
	property :id, Serial
	property :wdsl, String
	property :passport, String;
	property :password, String
end
DataMapper.finalize
