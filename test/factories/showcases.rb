# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :showcase do
    garage_id 1
    active false
    normal_offset 1
    iphone_offset 1
    caption "MyString"
    description "MyString"
  end
end
