class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis
  has_many :collaborators
  has_many :wikis, through: :collaborators

  enum role: [:standard, :premium, :admin]
  
  before_save { self.email = email.downcase }
  after_initialize :set_role_to_standard         
  
  private

  def set_role_to_standard 
    self.role ||= :standard
  end
end
