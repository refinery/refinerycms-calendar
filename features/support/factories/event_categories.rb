Factory.define :event_category do |f|
  f.sequence(:name) { |n| "Class/Lecture #{n}" }
end