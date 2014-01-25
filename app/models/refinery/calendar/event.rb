module Refinery
  module Calendar
    class Event < Refinery::Core::BaseModel
      extend FriendlyId


      translates :title, :excerpt, :description
      class Translation
        attr_accessible :locale
      end
      acts_as_indexed :fields => [:title, :excerpt, :description]


      attr_accessible :image_id
      belongs_to :image, :class_name => '::Refinery::Image'

      friendly_id :title, :use => :slugged

      belongs_to :venue
      has_and_belongs_to_many :categories


      validates :title, :presence => true, :uniqueness => true

      attr_accessible :title, :from, :to, :registration_link,
                      :venue_id, :category_ids, :excerpt, :description,
                      :featured, :position

      alias_attribute :from, :starts_at
      alias_attribute :to, :ends_at

      delegate :name, :address,
                :to => :venue,
                :prefix => true,
                :allow_nil => true

      scope :starting_on_day, lambda {|day| where(starts_at: day.beginning_of_day..day.tomorrow.beginning_of_day) }
      scope :ending_on_day, lambda {|day| where(ends_at: day.beginning_of_day..day.tomorrow.beginning_of_day) }

      scope :on_day, lambda {|day|
        where(
          arel_table[:starts_at].in(day.beginning_of_day..day.tomorrow.beginning_of_day).
          or(arel_table[:ends_at].in(day.beginning_of_day..day.tomorrow.beginning_of_day)).
          or( arel_table[:starts_at].lt(day.beginning_of_day).and(arel_table[:ends_at].gt(day.tomorrow.beginning_of_day)) )
        )
      }

      class << self
        def current
          where('refinery_calendar_events.starts_at < ?', Time.now)
            .where('refinery_calendar_events.ends_at >= ?', Time.now)
        end

        def upcoming
          where('refinery_calendar_events.starts_at >= ?', Time.now)
        end

        def featured
          where(:featured => true)
        end

        def archive
          where('refinery_calendar_events.ends_at < ?', Time.now)
        end

      end
    end
  end
end
