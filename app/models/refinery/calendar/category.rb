module Refinery
  module Calendar
    class Category < Refinery::Core::BaseModel
      has_and_belongs_to_many :events
      validates :name, presence: true, uniqueness: true
      attr_accessible :name, :position

      translates :name
      class Translation
        attr_accessible :locale
      end
      acts_as_indexed :fields => [:name]


    end
  end
end
