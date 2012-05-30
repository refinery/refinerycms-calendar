
FactoryGirl.define do
  factory :event, :class => Refinery::Calendar::Event do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

