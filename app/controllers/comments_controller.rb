class CommentsController < ApplicationController
  helper [:events, :comments]
  
  def create
    @event = Event.find(params[:id])
    if @event.comments.create(params[:comment]) and @event.save
      redirect_to event_path(@event, :anchor => 'commenting'), :notice => "Thank you for commenting!"
    else
      render :template => @event
    end
  end

  def reply
  end

end
