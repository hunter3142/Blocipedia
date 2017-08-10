class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  after_initialize :init         

  def init 
  	self.role ||= :standard
  end

  def downgrade
    current_user.update_attribute(:role, 'standard')
  end

  enum role: [:standard, :premium, :admin]
end
