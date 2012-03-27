module Refinery
  module Calendar
    class CoreCalendar
      attr_accessor :entries
      attr_writer :event_source

      def initialize
        @entries = []
      end

      def title
        Refinery::Calendar.title
      end

      def new_event(*args)
        event_source.call(*args).tap do |e|
          e.calendar = self
        end
      end

      def add_entry(entry)
        entries << entry
      end

      private

      def event_source
        @event_source ||= Event.public_method(:new)
      end
    end
  end
end
