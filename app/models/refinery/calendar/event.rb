module Refinery
  module Calendar
    class Event
      extend ActiveModel::Naming
      include ActiveModel::Conversion
      include ActiveModel::Validations
      include Refinery::Engine::MultiparameterAssignment

      attr_accessor :title, :starts, :ends, :body, :calendar

      def initialize(attrs={})
        setup_parameters(attrs)
        attrs.each do |k,v| send("#{k}=",v) end
      end

      def publish
        calendar.add_entry(self)
      end

      def persisted?
        false
      end
    end
  end
end
