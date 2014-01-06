class AdminMailerMailer < ActionMailer::Base
	#raise "hi"
  default from: "atishkunalinfotech@gmail.com"

  def registration(admin_mailer)

  	@admin_mailer = admin_mailer
  	#raise admin_mailer.message.inspect
    mail(:to => "atishkunalinfotech@gmail.com", :subject => admin_mailer.message)
  end
end
