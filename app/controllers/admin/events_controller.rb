module Admin
  class EventsController < Admin::BaseController

    crudify :event, :xhr_paging => true

    def index
      search_all_events if searching?

      @archived = Event.archive
      @upcoming = Event.upcoming
      @current = Event.current

      @events = (@archived | @upcoming | @current)

      render :partial => 'events' if request.xhr?
    end

  end
end
