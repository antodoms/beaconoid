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

