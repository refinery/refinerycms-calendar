module Refinery
  module Calendar
    module Admin
      class EventsController < ::Refinery::AdminController
        before_action :find_venues, except: [:index, :destroy]

        crudify :'refinery/calendar/event',
                sortable: false,
                order: "starts_at DESC"

        private

        def find_venues
          @venues = Venue.order('name')
        end
      end
    end
  end
end
