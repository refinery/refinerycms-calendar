module Refinery
  module Calendar
    class Category < Refinery::Core::BaseModel
      has_many :events
      validates :name, presence: true, uniqueness: true
      attr_accessible :name, :position
    end
  end
end
