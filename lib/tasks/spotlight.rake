namespace :update do
  desc "Update Spotlighted at to car profile records."
  task :spotlighted_at => :environment do
	Carprofile.all.each do |carprofile|
		carprofile.update_attribute("spotlighted_at",DateTime.now-5.day)
	end	
    puts "Updated Records for CarProfile !!!"
  end
end