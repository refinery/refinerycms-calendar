module Refinery
  module Calendar
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::Calendar

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.pathname   = root
          plugin.name       = 'refinery_calendar'
          plugin.url        = proc { Refinery::Core::Engine.routes.url_helpers.calendar_admin_events_path }
          plugin.menu_match = %r{refinery/calendar(/.*)?$}
        end

        Rails.application.config.assets.precompile += %w(
          chosen.jquery.min.js
          jquery.ui.timepicker.addon.js
          refinery/calendar.js

          chosen.css
          jquery-ui.css
          refinery/calendar.css
        )
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Calendar)
      end
    end
  end
end
