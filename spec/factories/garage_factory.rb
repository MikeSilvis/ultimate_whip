FactoryGirl.define do
  factory :garage do
    association :user, factory: :user, strategy: :build
    association :model, factory: :model, strategy: :build
    association :color, factory: :color, strategy: :build
    year 2011
  end
end
