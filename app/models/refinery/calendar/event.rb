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

      delegate :name, :address,
                :to => :venue,
                :prefix => true,
                :allow_nil => true

      scope :on_day, lambda {|day| where('(refinery_calendar_events.`from` = ?) OR (refinery_calendar_events.`to` = ?) OR (refinery_calendar_events.`from` < ? AND (refinery_calendar_events.`to` > ?))', day, day, day, day) }

      class << self
        def upcoming
          where('refinery_calendar_events.from >= ?', Time.now)
        end

        def featured
          where(:featured => true)
        end

        def archive
          where('refinery_calendar_events.from < ?', Time.now)
        end
      end
    end
  end
end
