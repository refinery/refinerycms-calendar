module Refinery
  module Calendar
    module Admin
      class EventsController < ::Refinery::AdminController
        before_filter :find_categories, :except => [:index, :destroy]
        before_filter :find_venues, :except => [:index, :destroy]

        crudify :'refinery/calendar/event',
                :xhr_paging => true,
                :sortable => false,
                :order => "starts_at DESC"

        private
        def find_venues
          @venues = Venue.order('name')
        end
        def find_categories
          @categories = Category.order('name')
        end
      end
    end
  end
end
