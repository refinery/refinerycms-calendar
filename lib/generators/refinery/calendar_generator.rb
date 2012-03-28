module Refinery
  class CalendarGenerator < Rails::Generators::Base

    def create_initializer_file
      create_file 'config/initializers/refinery/calendar.rb',
        <<-EOH
REFINERY_CALENDAR = Refinery::Calendar::CoreCalendar.new

Refinery::Calendar.configure do |config|
  config.title = 'RefineryCMS Calendar'
end
        EOH
    end

#    def rake_db
#      rake("refinery_calendar:install:migrations")
#    end

    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

Refinery::Calendar::Engine.load_seed
        EOH
      end
    end
  end
end
