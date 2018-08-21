require 'responders'

module Refinery
  module Calendar
    class EventsController < ::ApplicationController
      before_action :find_page, except: :archive

      respond_to :html

      def index
        @events = Event.upcoming.order(starts_at: :desc)

        present @page
      end

      def show
        @event = Event.friendly.find(params[:id])

        present @page
      end

      def archive
        @events = Event.archive.order(starts_at: :desc)
        render template: 'refinery/calendar/events/index'
      end

      protected

      def find_page
        @page = ::Refinery::Page.where(link_url: '/calendar/events').first
      end

    end
  end
end
