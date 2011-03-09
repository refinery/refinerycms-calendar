require 'refinery'

module Refinery
  module Events
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "events"
          plugin.activity = [{
            :class => Event
          }, {
            :class => EventCategory
          }]
          plugin.menu_match = /^(admin|refinery)\/(event(_categorie)?s)/
        end
      end
    end
  end
end
