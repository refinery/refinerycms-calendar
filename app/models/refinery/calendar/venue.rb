module Refinery
  module Calendar
    class Venue < Refinery::Core::BaseModel
      translates :name
      has_many :events
      validates :name, :presence => true, :uniqueness => true
      attr_accessible :name, :address, :url, :phone, :position

      attr_accessor :locale

      class Translation
        attr_accessible :locale
      end

    end
  end
end
