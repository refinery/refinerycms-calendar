Factory.define :comment do |f|
  f.sequence(:name) { |n| "Joe Sak #{n}" }
  f.comment "Bitches, please."
  f.association :commentable, :factory => :event
end

Factory.define :reply do |f|
  f.sequence(:name) { |n| "Replier #{n}" }
  f.comment "Man, WHATEVER"
  f.association :commentable, :factory => :comment
end