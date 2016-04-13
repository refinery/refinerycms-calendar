module Refinery
  module Calendar
    class Venue < Refinery::Core::BaseModel
      has_many :events
      validates :name, :presence => true, :uniqueness => true
    end
  end
end
