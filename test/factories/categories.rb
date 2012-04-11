# Read about factories at https://github.com/thoughtbot/factory_girl

#FactoryGirl.define do
# factory :category do
#    name => "My book category"
#    book_id => 1
#  end
# 
#end

Factory.define :category do |f|
  #f.sequence(:title) { |n| "my_title_#{n}" }
  f.name 'Efi Code'
  f.book_id 4
  #f.description 'Book description'
end
