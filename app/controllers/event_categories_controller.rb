class EventCategoriesController < ApplicationController
  helper [:events, :comments, :event_categories]
  
  def show
    @event_category = EventCategory.find(params[:id])
  end
  
end