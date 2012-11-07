module Refinery
  module Calendar
    class Event < Refinery::Core::BaseModel
      extend FriendlyId

      friendly_id :title, :use => :slugged

      belongs_to :venue

      validates :title, :presence => true, :uniqueness => true

      attr_accessible :title, :from, :to, :registration_link,
                      :venue_id, :excerpt, :description,
                      :featured, :position

      alias_attribute :from, :starts_at
      alias_attribute :to, :ends_at

      delegate :name, :address,
                :to => :venue,
                :prefix => true,
                :allow_nil => true

      scope :on_day, lambda {|day| where('
        ( (refinery_calendar_events.starts_at >= ?) AND (refinery_calendar_events.starts_at < ?))
        OR ((refinery_calendar_events.ends_at >= ?) AND (refinery_calendar_events.ends_at < ?))
        OR (refinery_calendar_events.starts_at < ? AND (refinery_calendar_events.ends_at > ?))', day, day + 1.day, day, day + 1.day, day, day) }

      class << self
        def upcoming
          where('refinery_calendar_events.starts_at >= ?', Time.now).with_globalize
        end

        def featured
          where(:featured => true)
        end

        def archive
          where('refinery_calendar_events.starts_at < ?', Time.now).with_globalize
        end

      end
    end
  end
end
