module Refinery
  module Calendar
    module Admin
      class EventsController < ::Refinery::AdminController

        before_action :find_venues, except: [:index, :destroy]

        crudify :'refinery/calendar/event',
                sortable: false,
                order: "starts_at DESC"

        protected

        def event_params
          params.require(:event).permit(permitted_event_params)
        end

        private

        def find_venues
          @venues = Venue.order('name')
        end

        def permitted_event_params
          [
            :title, :from, :to, :registration_link,
            :venue_id, :excerpt, :description,
            :featured, :position, :picture_id
          ]
        end
      end
    end
  end
end
