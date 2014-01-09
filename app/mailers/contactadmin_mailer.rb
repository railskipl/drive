class ContactadminMailer < ActionMailer::Base
 default from: "atishkunalinfotech@gmail.com"

  

  def self.send_replacement_request(contactadmin)
     users = User.all
     #raise contactadmin.inspect
  	@contactadmin = contactadmin
    	#raise u.email.inspect
    
    users.each do |u|
    	registration_confirmation(u,contactadmin).deliver
    end
   end

    def registration_confirmation(user, contactadmin)

   	 @full_name = "#{user.first_name} #{user.last_name}"
   	 @contactadmin = contactadmin
     mail(:to => user.email, :subject => contactadmin.subject)
    end
end
