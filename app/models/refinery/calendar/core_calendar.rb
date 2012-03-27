module Refinery
  module Calender
    class CoreCalendar
      attr_accessor :entries

      def title
        Refinery::Calendar.title
      end
    end
  end
end
