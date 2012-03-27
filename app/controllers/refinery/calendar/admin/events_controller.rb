module Refinery
  module Calendar
    module Admin
      class EventsController < ::Refinery::AdminController

        crudify :'refinery/calendar/event', :xhr_paging => true

      end
    end
  end
end
