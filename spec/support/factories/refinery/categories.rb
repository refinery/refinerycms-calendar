
FactoryGirl.define do
  factory :category, :class => Refinery::Calendar::Category do
    sequence(:name) { |n| "category#{n}" }
  end
end

