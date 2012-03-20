class Book < ActiveRecord::Base
  
  validates :title, presence: true, uniqueness: true
  validates :authors, presence: true
  
  validates_with IsbnValidator
  
  has_many :reservations
  has_many :taggings
  has_many :tags, through: :taggings
  
  def reservation
    self.reservations.where(state: 'reserved').first
  end
  
  def tag_with(tag_name)
    if tags.where(name: tag_name).empty?
      tag = Tag.find_or_create_by_name(tag_name)
      tags << tag
      tag
    else
      nil
    end
  end
  
  def self.search_by_isbn(value)
    self.where(isbn: value)
  end

  def self.search_by_authors(value)
    self.where("authors LIKE ?", "%#{value}%").order(
               "authors asc, created_at desc")
  end

  def self.search_by_title(value)
    self.where("title LIKE ?", "%#{value}%").order(
         "title asc, created_at desc")
  end


  
end
