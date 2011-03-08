Factory.define :event do |f|
  f.sequence(:title) { |n| "Top #{n} Shopping Centers in Chicago" }
  f.description "These are the top ten shopping centers in Chicago. You're going to read a long blog post about them. Come to peace with it."
  f.start_at Time.now
  f.end_at Time.now.advance(:hours => 1)
end