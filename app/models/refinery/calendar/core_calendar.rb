module Refinery
  module Calendar
    class CoreCalendar
      attr_accessor :entries
      attr_writer :entry_source

      def initialize
        @entries = []
      end

      def title
        Refinery::Calendar.title
      end

      def new_entry
        entry_source.call do |e|
          e.calendar = self
        end
      end

      def add_entry(entry)
        entries << entry
      end

      private

      def entry_source
        @entry_source ||= Event.public_method(:new)
      end
    end
  end
end
