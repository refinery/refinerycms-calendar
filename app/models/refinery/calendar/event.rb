module Refinery
  module Calendar
    class Event
      extend ActiveModel::Naming
      include ActiveModel::Conversion
      include ActiveModel::Validations

      attr_accessor :title, :starts, :ends, :body, :calendar

      def initialize(attrs={})
        setup_parameters(attrs).each do |k,v| send("#{k}=",v) end
      end

      def publish
        calendar.add_entry(self)
      end

      def persisted?
        false
      end

      def setup_parameters(attrs={})
        datetime = ''
        new_params = {}
        attrs.each do |key, value|
          if (k = key.to_s.match(/^(starts|ends)\(/) { |m| m[1] })
            datetime += "#{value}-"
          else
            new_params[key] = value
          end

          if datetime.split('-').length == 3
            new_params[k] = DateTime.parse(datetime.gsub(/-$/,''))
            datetime = ''
          end
        end
        return new_params
      end
    end
  end
end
