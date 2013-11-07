class ContactMailer < ActionMailer::Base
  default from: "atishkunalinfotech@gmail.com"

  def registration_confirmation(contact)
  	@contact = contact
    mail(:to => "atishkunalinfotech@gmail.com", :subject => contact.subject)
  end
end
