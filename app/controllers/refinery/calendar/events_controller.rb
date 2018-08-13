require 'responders'

module Refinery
  module Calendar
    class EventsController < ::ApplicationController
      before_action :find_page, except: :archive

      respond_to :html

      def index
        @events = Event.upcoming.order(starts_at: :desc)

        respond_with (@events) do |format|
          format.html
#           format.rss { render layout: false }
        end
      end

      def show
        @event = Event.friendly.find(params[:id])

        respond_with (@event) do |format|
          format.html { present(@event) }
#           format.js { render partial: 'post', layout: false }
        end
      end

      def archive
        @events = Event.archive.order(starts_at: :desc)
        render :template => 'refinery/calendar/events/index'
      end

      protected

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/calendar/events").first
      end

    end
  end
end
