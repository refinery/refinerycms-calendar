# Encoding: UTF-8
$:.push File.expand_path('../lib', __FILE__)
require 'refinery/calendar/version'

version = Refinery::Calendar::Version.to_s

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-calendar'
  s.version           = version
  s.description       = 'Ruby on Rails Calendar extension for Refinery CMS'
  s.date              = '2012-03-26'
  s.summary           = 'Calendar extension for Refinery CMS'
  s.authors           = ['Joe Sak']
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.0.2'
end
