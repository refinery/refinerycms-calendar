module EventsHelper
  
  def custom_url_for(event, format = nil)
    port = request.port == 80 ? nil : ":#{request.port}"
    "#{request.protocol}#{request.host}#{port}/events/#{event.friendly_id}#{format}"
  end

  def events_archive_list
    events = Event.select('start_at').for_archive_list
    return nil if events.blank?
    html = '<ul>'
    links = []
    super_old_links = []

    events.each do |e|
      if e.start_at >= Time.now.end_of_year.advance(:years => -3)
        links << e.start_at.strftime('%m/%Y') 
      else
        super_old_links << e.start_at.strftime('01/%Y')
      end
    end
    links.uniq!
    super_old_links.uniq!
    links.each do |l|
      year = l.split('/')[1]
      month = l.split('/')[0]
      count = Event.by_archive(Time.parse(l)).size
      text = t("date.month_names")[month.to_i] + " #{year} (#{count})"      
      html << "<li>"
      html << link_to(text, archive_events_path(:year => year, :month => month))
      html << "</li>"
    end
    super_old_links.each do |l|
      year = l.split('/')[1]
      count = Event.by_year(Time.parse(l)).size
      text = "#{year} (#{count})"
      html << "<li>"
      html << link_to(text, archive_events_path(:year => year))
      html << "</li>"
    end
    html << '</ul>'
    html.html_safe
  end
end