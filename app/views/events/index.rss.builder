xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title RefinerySetting.find_or_set(:site_name, "Pastoral Artisan Cheese, Bread & Wine")
    xml.description RefinerySetting.find_or_set(:site_name, "Pastoral Artisan Cheese, Bread & Wine") + " Events"
    xml.link events_url

    (@featured_events | @events).each do |event|
      xml.item do
        xml.title "Featured: #{event.title}"
        xml.description simple_format(strip_tags event.description)

        xml.start_at event.start_at.to_s(:rfc822)
        xml.end_at event.end_at.to_s(:rfc822)

        xml.ticket_price number_to_currency(event.ticket_price) unless event.ticket_price.blank?
        xml.ticket_link event.ticket_link unless event.ticket_link.blank?

        xml.link event_url(event)
        xml.pubDate event.created_at.to_s(:rfc822)
      end
    end
  end
end