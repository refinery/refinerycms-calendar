module Admin
  class EventCategoriesController < Admin::BaseController

    crudify :event_category,
            :title_attribute => :name,
            :xhr_paging => true

  end
end
