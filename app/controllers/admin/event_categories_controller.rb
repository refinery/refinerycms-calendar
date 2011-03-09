module Admin
  class EventCategoriesController < Admin::BaseController

    crudify :event_category,
            :title_attribute => :name

    def index
      raise ">>>>>>>>>>>> HI HIHIHIHIH".inspect
      search_all_event_categories if searching?
      paginate_all_event_categories

      render :partial => 'event_categories' if request.xhr?
    end

  end
end
