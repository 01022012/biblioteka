class User < ActiveRecord::Base
  
  has_secure_password
  
  attr_accessible :email, :password, :password_confirmation
    
  validates :email, presence: true, uniqueness: true

  def serializable_hash(options = {})
    {id: id, email: email}
  end
  
  def feed
    Comment.where("user_id = ?", id)
    
  end
end
