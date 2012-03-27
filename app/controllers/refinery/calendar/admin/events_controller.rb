module Refinery
  module Calendar
    module Admin
      class EventsController < ::Refinery::AdminController
        before_filter :init_calendar

        def index
          @events = []
        end

        def new
          @event = @calendar.new_event
        end

        def create
          @event = @calendar.new_event(params[:event])
          @event.publish
          redirect_to admin_refinery_calendar_events_path
        end

        def self.searchable?
          false
        end

        def self.sortable?
          false
        end

        private
        def init_calendar
          @calendar = REFINERY_CALENDAR
        end
      end
    end
  end
end
