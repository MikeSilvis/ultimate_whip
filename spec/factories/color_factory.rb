FactoryGirl.define do
  factory :color do
    sequence(:name) { |n| "color_name#{n}" }
  end
end
