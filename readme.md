# Events engine for Refinery CMS.

* Venue Details
* Ticket pricing & Link
* Mark featured events
* Specify a main image
* Archives
* Categories
* Basic layout and styling to get started immediately [blake0102](http://github.com/blake0102)
* Easily hook onto a few semantic CSS classes built into the markup [blake0102](http://github.com/blake0102)
* Basic Facebook & Twitter sharing interface
* RSS feed

# Install

Using Rails 3 / Bundler Gemfile:

    gem 'refinerycms-calendar', '~>1.1.0'

bash:

    bundle install

    rails g refinerycms_calendar

    rake db:migrate



Maintained by [joemsak](http://github.com/joemsak)

## TODO for 1.1.1:

* Controller & view template refactoring


## TODO for 1.2 Release:

* Import events from Facebook fan page?
* JS datepicker in admin backend
* Calendar grid view? (can be kinda gross, honestly)
* Address finder?

## Acknowledgements

* [Ed Blake](http://github.com/blake0102) structured semantic markup and design-minded workflow.
* [Neoteric Design, Inc.](http://www.neotericdesign.com) support and enthusiasm for my time & energy spent on helping the Refinery community.
* [Philip Arndt](http://github.com/parndt) Core team, RefineryCMS. Built the generator that makes this engine possible.
* [Resolve Digital](http://www.resolvedigital.com) The company behind the fabulous [RefineryCMS](http://www.refinerycms.com).
