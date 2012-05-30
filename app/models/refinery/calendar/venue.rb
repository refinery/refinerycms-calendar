module Refinery
  module Calendar
    class Venue < Refinery::Core::BaseModel
      has_many :events
      validates :name, :presence => true, :uniqueness => true
      attr_accessible :name, :address, :url, :phone, :position
    end
  end
end
