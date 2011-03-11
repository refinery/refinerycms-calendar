class EventCategoriesController < ApplicationController
  helper [:events, :event_categories]
  
  def show
    @event_category = EventCategory.find(params[:id])
    @event_categories = EventCategory.all
    @other_events = Event.live.limit(5)
  end
  
end