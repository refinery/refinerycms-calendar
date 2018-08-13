require 'refinerycms-core'
require 'refinerycms-settings'
require 'rails_autolink'
require 'friendly_id'
require 'jquery-ui-rails'
require 'globalize'
require 'seo_meta'

module Refinery
  autoload :CalendarGenerator, 'generators/refinery/calendar/calendar_generator'

  module Calendar
    require 'refinery/calendar/engine'
    require 'refinery/calendar/configuration'

    autoload :Version, 'refinery/calendar/version'
    autoload :Tab, 'refinery/calendar/tabs'

    class << self
      attr_writer :root
      attr_writer :tabs

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def tabs
        @tabs ||= []
      end

      def version
        ::Refinery::Calendar::Version.to_s
      end

      def factory_paths
        @factory_paths ||= [ root.join("spec/factories").to_s ]
      end
    end
  end
end
