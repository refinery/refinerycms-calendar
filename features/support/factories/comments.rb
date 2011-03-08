Factory.define :comment do |f|
  f.sequence(:name) { |n| "Joe Sak #{n}" }
  f.comment "Bitches, please."
  f.association :event
end