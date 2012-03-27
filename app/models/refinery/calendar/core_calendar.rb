module Refinery
  module Calendar
    class CoreCalendar
      attr_accessor :entries

      def initialize
        @entries = []
      end

      def title
        Refinery::Calendar.title
      end
    end
  end
end
