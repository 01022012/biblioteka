class Comment < ActiveRecord::Base

  attr_accessible :content
  
  validates :book_id, presence: true
  validates :content, presence: true
  validates :user_id, presence: true
                   
  belongs_to :book
  

end
