class CommentsController < ApplicationController
  helper [:events, :comments]
  
  def create
    @event = Event.find(params[:id])
    @comment = @event.comments.build(params[:comment])
    if @comment.save
      redirect_to event_path(@event, :anchor => 'commenting'), :notice => "Thank you for commenting!"
    else
      render :template => "events/show"
    end
  end

  def reply
  end

end
