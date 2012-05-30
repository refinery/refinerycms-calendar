module Refinery
  module Calendar
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Calendar

      engine_name :refinery_calendar

      initializer "register refinerycms_events plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "calendar"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.calendar_admin_events_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/calendar/event'
          }
          plugin.menu_match = %r{refinery/calendar(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Events)
      end
    end
  end
end
