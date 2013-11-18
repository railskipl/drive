class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :validatable
   
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:first_name,:last_name,:nickname,:birthday,:location,:agree,:status,
                   :freecredit, :buycredit, :credit

  # attr_accessible :title, :body
  validates_uniqueness_of :email, :password

  has_many :carprofiles
  has_many :logbooks

 


  def credit_points(current_user)
    @credit = Credit.first
    if current_user.freecredit == @credit.free_credit
    elsif current_user.current_sign_in_at > current_user.last_sign_in_at

   

        credit_added = current_user.current_sign_in_at.to_date - current_user.last_sign_in_at.to_date
        if credit_added <= 7
           current_user.freecredit = current_user.freecredit + credit_added
           current_user.credit = current_user.freecredit + current_user.buycredit
           current_user.save
        end 
    end
  end

end
