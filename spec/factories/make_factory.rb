FactoryGirl.define do
  factory :make do
    sequence(:name) { |n| "make_name#{n}" }
  end
end
