module Refinery
  module Calendar
    class Event
      extend ActiveModel::Naming
      include ActiveModel::Conversion
      include ActiveModel::Validations

      attr_accessor :title, :starts, :ends, :body, :calendar

      validates :title, :presence => true

      def initialize(attrs={})
        setup_parameters(attrs).each do |k,v| send("#{k}=",v) end
      end

      def publish
        return false unless valid?
        calendar.add_entry(self)
      end

      def persisted?
        false
      end

      def setup_parameters(attrs={})
        i = 0
        datetime = ''
        new_params = {}
        attrs.each do |key, value|
          if (k = key.to_s.match(/^(starts|ends)\(/) { |m| m[1] })
            sep = '-'
            sep = 'T' if i == 2
            sep = ':' if i > 2
            datetime += "#{value}#{sep}"
            i += 1
          else
            new_params[key] = value
          end

          if datetime.split(':').length == 2
            datetime += Time.new.zone
            new_params[k] = DateTime.parse(datetime.gsub(/:$/,''))
            datetime = ''
            i = 0
          end
        end
        return new_params
      end
    end
  end
end
