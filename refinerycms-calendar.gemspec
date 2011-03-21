Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-calendar'
  s.version           = '1.0.2'
  s.description       = 'Ruby on Rails Events engine for Refinery CMS'
  s.date              = '2011-03-03'
  s.summary           = 'Events engine for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir['**/*']
  s.authors           = ["Neoteric Design", "Joe Sak", "Philip Arndt"]
  s.email             = %q{joe@neotericdesign.com}
  s.homepage          = "https://github.com/resolve/refinerycms-calendar"

  s.add_dependency    'refinerycms',  '>= 0.9.9'
end


