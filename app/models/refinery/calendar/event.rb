module Refinery
  module Calendar
    class Event
      attr_accessor :title, :starts, :ends, :body, :calendar

      def initialize(attrs={})
        attrs.each do |k,v| send("#{k}=",v) end
      end

      def publish
        calendar.add_entry(self)
      end
    end
  end
end
