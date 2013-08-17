module Refinery
  module Calendar
    class CategoriesController < ::ApplicationController

      def index
        @categories = Category.order('refinery_calendar_categories.name')
      end

      def show
        @category = Category.find(params[:id])
      end
      # before_filter :find_page, :except => :archive

      # def index
      #   @events = Event.upcoming.order('refinery_calendar_events.starts_at DESC')

      #   # you can use meta fields from your model instead (e.g. browser_title)
      #   # by swapping @page for @event in the line below:
      #   present(@page)
      # end

      # def show
      #   @event = Event.find(params[:id])

      #   # you can use meta fields from your model instead (e.g. browser_title)
      #   # by swapping @page for @event in the line below:
      #   present(@page)
      # end

      # def archive
      #   @events = Event.archive.order('refinery_calendar_events.starts_at DESC')
      #   render :template => 'refinery/calendar/events/index'
      # end

      # protected
      # def find_page
      #   @page = ::Refinery::Page.where(:link_url => "/calendar/events").first
      # end

    end
  end
end
