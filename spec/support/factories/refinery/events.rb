
FactoryGirl.define do
  factory :event, :class => Refinery::Calendar::Event do
    sequence(:title) { |n| "refinery#{n}" }
    start_at '2011-04-01 12:00:00'
    end_at '2011-04-01 18:00:00'
  end
end

