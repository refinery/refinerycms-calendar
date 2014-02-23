module Refinery
  module Calendar
    class EventsController < ::ApplicationController
      before_filter :find_page, :except => :archive
      before_filter :find_categories

      def index
        @events          = Event.upcoming.order('refinery_calendar_events.starts_at DESC')
        @featured_events = Event.upcoming.featured.order('refinery_calendar_events.starts_at')
        @upcoming_events = Event.upcoming.order('refinery_calendar_events.starts_at')
        @current_events  = Event.current.order('refinery_calendar_events.starts_at')
        @past_events     = Event.archive.order('refinery_calendar_events.starts_at DESC')

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @event in the line below:
        present(@page)
      end

      def show
        @event = Event.find(params[:id])
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @event in the line below:
        present(@event)
      end

      def archive
        @events = Event.archive.order('refinery_calendar_events.starts_at DESC')
        render :template => 'refinery/calendar/events/index'
      end

      protected
      def find_page
        @page = ::Refinery::Page.where(:link_url => "/calendar/events").first
      end
      def find_categories
        @categories ||= Refinery::Calendar::Category.order( 'refinery_calendar_categories.name')
      end

    end
  end
end
