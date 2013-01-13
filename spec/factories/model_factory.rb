FactoryGirl.define do
  factory :model do
    sequence(:name) { |n| "model_name#{n}" }
    association :make, factory: :make, strategy: :build
  end
end
