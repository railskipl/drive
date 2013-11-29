# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Creating Admin Account"
Admin.find_or_create_by_email(:email => "admin@gmail.com" , :password => "admin123!")
puts "Creating Seo Account"
Seo.find_or_create_by_meta_title(:meta_title => "Welcome to driveblogs.com", :meta_description => "The driveblogs web application is a comprehensive online cars platform geared towards the cars lovers.", :meta_keyword => "The driveblogs web application is a comprehensive online cars platform geared towards the cars lovers." )

puts "creating visiblity"

Visibility.create(:profile_type => "public")
Visibility.create(:profile_type => "personal")
Visibility.create(:profile_type => "anonymous")