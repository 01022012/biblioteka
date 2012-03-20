# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  sequence :name do |i|
    "tag_#{i}"
  end
  
  factory :tag do
    name
  end
  
end
