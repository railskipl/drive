class NotificationsController < ApplicationController
	  before_filter :authenticate_user!

	def index

	   @notifications = Notification.find(:all, :order => "created_at DESC")
	   #@notifications = @notifications.delete_if {|i| i.user_id == current_user.id }
	   remove
       #raise @notifications.inspect
       #.paginate(page: params[:page], per_page: 5)
	end

	def remove

		@notifications.each do |noti|
  
	      a = Time.now
	      if a > noti.created_at
	        c = a.to_date - (noti.created_at).to_date
	       
	        if c >= 30

	          noti.destroy
	        else
	        
	        end
	      end
       end
	end
end
