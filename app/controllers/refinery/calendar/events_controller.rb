module Refinery
  module Calendar
    class EventsController < ::ApplicationController

      helper 'refinery/calendar/calendar'

      def index
        d = Date.parse(params[:date]) rescue nil
        @events = d.nil? ?
          Event.upcoming.order('refinery_calendar_events.from DESC') :
          Event.on_day(d).order('refinery_calendar_events.from DESC')

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @event in the line below:
        present(@page)
      end

      def show
        @event = Event.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @event in the line below:
        present(@page)
      end

      def archive
        @events = Event.archive.order('refinery_calendar_events.from DESC')
        render :template => 'refinery/calendar/events/index'
      end

      protected
      def find_page
        @page = ::Refinery::Page.where(:link_url => "/calendar/events").first
      end

    end
  end
end
