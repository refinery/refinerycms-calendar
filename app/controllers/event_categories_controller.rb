class EventCategoriesController < ApplicationController
  helper [:events, :event_categories]
  
  def show
    @event_category = EventCategory.find(params[:id])
    @event_categories = EventCategory.all
    @other_events = Event.live.limit(5)
    # @events = @event_category.events.paginate({
    #       :page => params[:page],
    #       :per_page => RefinerySetting.find_or_set(:events_per_page, 10)
    #     })
    #     render :template => 'events/index'
  end
  
end