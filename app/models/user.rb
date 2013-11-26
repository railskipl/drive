class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :validatable
   
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:first_name,:last_name,:nickname,:birthday,:location,:agree,:status,
                   :freecredit, :buycredit, :credit,:about

  # attr_accessible :title, :body

  has_many :carprofiles,dependent: :destroy
  has_many :logbooks, dependent: :destroy
  has_many :user_blogs, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :notifications, dependent: :destroy


 acts_as_liker

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
  
    elsif current_user.credit >= current_user.spend_credit && current_user.current_sign_in_at > current_user.last_sign_in_at
     c = current_user.credit - current_user.spend_credit
     credit_added = current_user.current_sign_in_at.to_date - current_user.last_sign_in_at.to_date
      if c <= 7 && credit_added <= 7
        current_user.freecredit = current_user.freecredit + credit_added
        current_user.credit = current_user.freecredit + current_user.buycredit
        current_user.save
      end
    end
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
end



