class EventsController < ApplicationController

  before_filter :find_all_events
  before_filter :find_page
  helper [:events, :comments]

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @event in the line below:
    present(@page)
  end

  def show
    @event = Event.find(params[:id])
    @comment = @event.comments.build
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @event in the line below:
    present(@page)
  end
  
  def archive
    if params[:month].present?
      date = "#{params[:month]}/#{params[:year]}"
      @archive_date = Time.parse(date)
      @date_title = @archive_date.strftime('%B %Y')
      @events = Event.by_archive(@archive_date).paginate({
        :page => params[:page],
        :per_page => RefinerySetting.find_or_set(:events_per_page, 10)
      })
    else
      date = "01/#{params[:year]}"
      @archive_date = Time.parse(date)
      @date_title = @archive_date.strftime('%Y')
      @events = Event.by_year(@archive_date).paginate({
        :page => params[:page],
        :per_page => RefinerySetting.find_or_set(:events_per_page, 10)
      })
    end
  end

protected

  def find_all_events
    upcoming = Event.upcoming.not_featured
    current = Event.current.not_featured
    @events = (upcoming | current).sort { |a,b| a.start_at <=> b.start_at }
    
    featured_upcoming = Event.upcoming.featured
    featured_current = Event.current.featured
    @featured_events = (featured_upcoming | featured_current).sort { |a,b| a.start_at <=> b.start_at }
  end

  def find_page
    @page = Page.find_by_link_url("/events")
  end

end
