# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create(:email => "admin@gmail.com" , :password => "admin123!")

Seo.create(:meta_title => "Welcome to driveblogs.com", :meta_description => "The driveblogs web application is a comprehensive online cars platform geared towards the cars lovers.", :meta_keyword => "The driveblogs web application is a comprehensive online cars platform geared towards the cars lovers." )