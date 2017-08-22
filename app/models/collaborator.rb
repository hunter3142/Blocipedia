class Collaborator < ActiveRecord::Base
  belongs_to :wiki
  belongs_to :user
  
  @user_options = User.all.map { |u| [ u.email, u.id] }

end