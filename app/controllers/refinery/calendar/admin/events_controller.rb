module Refinery
  module Calendar
    module Admin
      class EventsController < ::Refinery::AdminController
        before_filter :init_calendar

        def index
          @events = @calendar.entries
        end

        def new
          @event = @calendar.new_event
        end

        def create
          @event = @calendar.new_event(params[:event])
          if @event.publish
            redirect_to refinery.calendar_admin_events_path
          else
            render :new
          end
        end

        def self.searchable?
          false
        end

        def self.pageable?
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
