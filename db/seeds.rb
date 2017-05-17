# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@user = User.find_by(:email => "antodoms@gmail.com")

if @user.present?
	@user.update(:role => "Admin")
else
	User.create(:email => "antodoms@gmail.com", :password => "password", :password_confirmation => "password", :role => "Admin")
end

@user = User.find_by(:email => "tanu.srinidhi@gmail.com")

if @user.present?
	@user.update(:role => "Beacon Manager")
else
	User.create(:email => "tanu.srinidhi@gmail.com", :password => "password", :password_confirmation => "password", :role => "Beacon Manager")
end

#binding.pry
if Category.count < 50
	(0..60).each do |x|
		Category.find_or_create_by(:name => Faker::Commerce.department, description: Faker::Commerce.product_name)
	end
end

if Store.count < 50
	(0..60).each do |x|
		Store.find_or_create_by(name: Faker::Address.street_name, unique_id: Faker::Company.duns_number, image_url: Faker::Avatar.image("x","500x300"))
	end
end

if Beacon.count < 2500
	(0..20).each do |x|
		Beacon.find_or_create_by(store_id: Store.all.sample.id, name: Faker::Commerce.promotion_code, current_status: ["Active","Inactive"].sample, unique_reference: Faker::Company.duns_number, latitude: Faker::Address.latitude, longitude: Faker::Address.longitude)
	end
end

if Advertisement.count < 2500
	(0..20).each do |x|
		string = "Buy #{Faker::Food.measurement} of #{Faker::Food.spice} and get a #{Faker::Food.ingredient} free"
		Advertisement.find_or_create_by(name: Faker::Commerce.product_name, beacon_id: Beacon.pluck(:id).sample, category_id: Category.pluck(:id).sample, price: Faker::Commerce.price, description: string)
	end
end

if Customer.count < 10000
	(1..1000).each do |x|
		Customer.find_or_create_by(:email => Faker::Internet.email)
	end
end

date1 = Time.now
date2 = Time.now - 1.year

CustomerTracking.destroy_all
if CustomerTracking.count < 100000
	(1..50000).each do |x|
		customer = Customer.pluck(:id).sample
		advertisement = Advertisement.all.sample
		beacon = advertisement.beacon
		time = Time.at((date2.to_f - date1.to_f)*rand + date1.to_f)
		CustomerTracking.create(customer_id: customer, category_id: advertisement.category_id, store_id: beacon.store_id, advertisement_id: advertisement.id, beacon_id: beacon.id, action: "click", time: time)

	end

	(1..100000).each do |x|
		customer = Customer.pluck(:id).sample
		beacon = Beacon.all.sample
		advertisements = beacon.advertisements
		time = Time.at((date2.to_f - date1.to_f)*rand + date1.to_f)
		CustomerTracking.create(customer_id: customer, category_id: advertisements.pluck(:category_id), store_id: beacon.store_id, advertisement_id: advertisements.pluck(:id), beacon_id: beacon.id, action: "fetch", time: time)
	end
end

