module Refinery
  module Calendar
    class Venue < ActiveRecord::Base
      has_many :events
      validates :name, :presence => true, :uniqueness => true
    end
  end
end
