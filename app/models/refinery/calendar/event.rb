module Refinery
  module Calendar
    class Event < ActiveRecord::Base
      extend FriendlyId

      friendly_id :title, :use => :slugged

      belongs_to :venue

      validates :title, :presence => true, :uniqueness => true

      alias_attribute :from, :starts_at
      alias_attribute :to, :ends_at

      delegate :name, :address,
                :to => :venue,
                :prefix => true,
                :allow_nil => true

      scope :starting_on_day, ->(day) { where(starts_at: day.beginning_of_day..day.tomorrow.beginning_of_day) }
      scope :ending_on_day, ->(day) { where(ends_at: day.beginning_of_day..day.tomorrow.beginning_of_day) }

      scope :on_day, ->(day) {
        where(
          arel_table[:starts_at].in(day.beginning_of_day..day.tomorrow.beginning_of_day).
          or(arel_table[:ends_at].in(day.beginning_of_day..day.tomorrow.beginning_of_day)).
          or(arel_table[:starts_at].lt(day.beginning_of_day).and(arel_table[:ends_at].gt(day.tomorrow.beginning_of_day)) )
        )
      }

      scope :upcoming, -> { where arel_table[:starts_at].gteq Time.now }

      scope :featured, -> { where featured: true }

      scope :archive, -> { where arel_table[:starts_at].lt Time.now }
    end
  end
end
