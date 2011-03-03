module Admin
  class EventsController < Admin::BaseController

    crudify :events,
              :redirect_to_url => :admin_events_index_url


    def index
      search_all_events if searching?
      paginate_all_events

      render :partial => 'events' if request.xhr?
    end

  end
end
