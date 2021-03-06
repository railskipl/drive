class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :validatable
   
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:first_name,:last_name,:nickname,:birthday,:location,:agree,:status,
                   :freecredit, :buycredit, :credit,:about,:pic,:visibility_status,:visibility_updated_on
  
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged]

  def slug_candidates
    [     
      ["#{first_name}", "#{last_name}" ]
    ]
  end


  # attr_accessible :title, :body

  has_many :carprofiles,dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :logbooks, dependent: :destroy
  has_many :user_blogs, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :comment_logbooks, dependent: :destroy
  has_many :blog_comments ,dependent: :destroy
  has_many :sent_egifts, :class_name => 'SendGift', :foreign_key => 'sender_id', :dependent => :destroy
  has_many :received_egifts, :class_name => 'SendGift', :foreign_key => 'receiver_id', :dependent => :destroy
  has_many :abuse_reports
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id', :dependent => :destroy
  has_many :recipient_messages, :class_name => 'Message', :foreign_key => 'recipient_id', :dependent => :destroy

  has_many :friendships
  #has_many :admin_mailers
  has_many :friends,
           :through => :friendships,
           :conditions => "flag = 'accepted'",
           :order => :id
 
  has_many :requested_friends,
           :through => :friendships,
           :source => :friend,
           :conditions => "flag = 'requested'",
           :order => :created_at

  has_many :pending_friends,
           :through => :friendships,
           :source => :friend,
           :conditions => "flag = 'pending'",
           :order => :created_at


  def self.json_tokens(query)
    users = where("email like ?", "%#{query}%")
    if users.empty?
    else
     users
    end
  end



 acts_as_liker

 acts_as_birthday :birthday

has_attached_file :pic,:styles => { :thumb => "140x100", :medium => "480x270>", :profile => "130x126"},
                   :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "public/attachments/user/:id/:style/:basename.:extension",
                    
                    :convert_options => {
                          :thumb => "-compose Copy -gravity center -extent 140x100",
                          :medium => "-compose Copy -gravity center -extent 350x350",
                          
                      }

  # def credit_points(current_user)
  #   @credit = Credit.first
  #   if current_user.freecredit == @credit.free_credit
  #   elsif current_user.current_sign_in_at > current_user.last_sign_in_at

   

  #       credit_added = current_user.current_sign_in_at.to_date - current_user.last_sign_in_at.to_date
  #       if credit_added <= 7
  #          current_user.freecredit = current_user.freecredit + credit_added
  #          current_user.credit = current_user.freecredit + current_user.buycredit
  #          current_user.save
  #       end 
  #   end
  # end

  def credit_points(current_user)
    @credit = Credit.first
    if current_user.freecredit == @credit.free_credit
      current_user.credit = current_user.freecredit + current_user.buycredit
      current_user.save
    elsif current_user.credit >= current_user.spend_credit && current_user.current_sign_in_at > current_user.last_sign_in_at
     c = current_user.credit - current_user.spend_credit
     credit_added = current_user.current_sign_in_at.to_date - current_user.last_sign_in_at.to_date
      if c <= 7 && credit_added <= 7
        current_user.freecredit = current_user.freecredit + credit_added
        current_user.credit = current_user.freecredit + current_user.buycredit
        current_user.save
      else
        #raise "hi"
        current_user.credit = current_user.freecredit + current_user.buycredit
        current_user.save
      end
    end
  end


  def check_message
      notifications =[]
      notifications = Notification.find(:all , :conditions => ["notifiable_id = '#{self.id}'"])
      count = 0
      notifications.each do |r|
        unless r.is_read
          count += 1
        end
      end
      return count
  end
  

  def spendcredits(current_user)

    if current_user.freecredit > current_user.buycredit 
      current_user.freecredit = current_user.freecredit - 1
      current_user.credit = current_user.freecredit + current_user.buycredit
      current_user.spend_credit = current_user.credit
       
       
    elsif 
      current_user.buycredit > current_user.freecredit 
      current_user.buycredit= current_user.buycredit - 1
      current_user.credit = current_user.freecredit + current_user.buycredit
      current_user.spend_credit = current_user.credit
       
      
    else
      current_user.buycredit == current_user.buycredit 
      current_user.freecredit = current_user.freecredit - 1
      current_user.credit = current_user.freecredit + current_user.buycredit
      current_user.spend_credit = current_user.credit
      
       #current_user.unlike!(@car_profile)      
    end
  end

  def spend_credit_egift(current_user, credit)
        if current_user.freecredit > current_user.buycredit 
         if current_user.credit >= credit
          current_user.freecredit = current_user.freecredit - credit
          current_user.credit = current_user.freecredit + current_user.buycredit
           current_user.spend_credit = current_user.credit
        else
        return 
       end
       
    elsif 
      current_user.buycredit > current_user.freecredit 
        if current_user.credit >= credit
          current_user.freecredit = current_user.freecredit - credit
          current_user.credit = current_user.freecredit + current_user.buycredit
           current_user.spend_credit = current_user.credit
        else
        return 
       end
       
      
    else
      current_user.buycredit == current_user.buycredit 
     if current_user.credit >= credit
         current_user.freecredit = current_user.freecredit - credit
         current_user.credit = current_user.freecredit + current_user.buycredit
         current_user.spend_credit = current_user.credit
        else
         return
       end
      
       #current_user.unlike!(@car_profile)      
    end
  end




end



