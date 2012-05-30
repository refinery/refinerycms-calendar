
FactoryGirl.define do
  factory :venue, :class => Refinery::Calendar::Venue do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

