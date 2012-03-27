module Refinery
  module Calendar
    module Admin
      class EventsController < ::Refinery::AdminController
        def index
          @events = []
        end

        def new
          @event = Event.new
        end

        def self.searchable?
          false
        end

        def self.sortable?
          false
        end
      end
    end
  end
end
