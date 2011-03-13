Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-events'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails Events engine for Refinery CMS'
  s.date              = '2011-03-03'
  s.summary           = 'Events engine for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir['lib/**/*', 'config/**/*', 'app/**/*', 'features/**/*', 'spec/**/*']
  s.authors           = ["Neoteric Design", "Joe Sak", "Philip Arndt"]

  s.add_dependency    'refinerycms',  '>= 0.9.9'
end


