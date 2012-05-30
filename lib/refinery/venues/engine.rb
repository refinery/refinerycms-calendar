module Refinery
  module Calendar
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Calendar

      engine_name :refinery_calendar

      config.after_initialize do
        Refinery.register_extension(Refinery::Venues)
      end
    end
  end
end
