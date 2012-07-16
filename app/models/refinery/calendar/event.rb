module Refinery
  module Calendar
    class Event < Refinery::Core::BaseModel
      extend FriendlyId

      friendly_id :title, :use => :slugged

      belongs_to :venue

      validates :title, :presence => true

      attr_accessible :title, :start_at, :end_at, :registration_link,
                      :venue_id, :excerpt, :description,
                      :featured, :position

      delegate :name, :address,
                :to => :venue,
                :prefix => true,
                :allow_nil => true

      class << self
        def upcoming
          where('refinery_calendar_events.start_at >= ?', Time.now)
        end

        def featured
          where(:featured => true)
        end

        def archive
          where('refinery_calendar_events.start_at < ?', Time.now)
        end
      end
    end
  end
end
