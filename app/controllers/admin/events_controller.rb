module Admin
  class EventsController < Admin::BaseController

    crudify :event

    def index
      search_all_events if searching?
      paginate_all_events

      render :partial => 'events' if request.xhr?
    end

  end
end
