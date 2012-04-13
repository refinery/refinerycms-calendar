module Refinery
  module Calendar
    class CoreCalendar < ActiveRecord::Base
      self.table_name = 'refinery_calendar_core_calendars'

      attr_writer :event_source

      def title
        Refinery::Calendar.title
      end

      def new_event(*args)
        event_source.call(*args).tap do |e|
          e.calendar = self
        end
      end

      def add_entry(entry)
        init_entries
        entry.calendar_id = id
        @entries << entry
      end

      def find_entry(id)
        init_entries
        idx = @entries.index { |e| id == e.id }
        return nil if idx.nil?
        @entries[idx]
      end

      def entries
        init_entries
        @entries.sort_by { |e| e.starts }
      end

      class << self
        def fetch(app)
          find_by_app(app)
        end
      end

      private
      def event_source
        @event_source ||= Event.public_method(:new)
      end

      def init_entries
        @entries ||= []
      end
    end
  end
end
