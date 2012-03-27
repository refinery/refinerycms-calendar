module Refinery
  module Calendar
    class Event
      attr_accessor :title, :starts, :ends, :body, :calendar

      def publish
        calendar.add_entry(self)
      end
    end
  end
end
