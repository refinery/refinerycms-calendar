class EventCategoriesController < ApplicationController
  helper [:events, :comments, :event_categories]
  
  def show
    @event_category = EventCategory.find(params[:id])
    @event_categories = EventCategory.all
  end
  
end