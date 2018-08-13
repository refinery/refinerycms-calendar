Refinery::User.all.each do |user|
  if user.plugins.where(:name => 'refinerycms_calendar').blank?
    user.plugins.create(:name => "refinerycms_calendar",
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end if defined?(Refinery::User)

if defined?(::Refinery::Page)
  url = "/calendar/venues"
  if ::Refinery::Page.where(:link_url => url).empty?
    page = ::Refinery::Page.create \
      :title => 'Venues',
      :link_url => url,
      :deletable => false,
      :menu_match => "^#{url}(\/|\/.+?|)$"

    Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
      page.parts.create(:title => default_page_part, :body => nil, :position => index)
    end
  end

  url = "/calendar/events"
  if ::Refinery::Page.where(:link_url => url).empty?
    page = ::Refinery::Page.create \
      :title => 'Events',
      :link_url => url,
      :deletable => false,
      :menu_match => "^#{url}(\/|\/.+?|)$"

    Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
      page.parts.create(:title => default_page_part, :body => nil, :position => index)
    end
  end
end


# Added by Refinery CMS Pages extension
Refinery::Pages::Engine.load_seed
