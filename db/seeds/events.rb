User.find(:all).each do |user|
  if user.plugins.find_by_name('events').nil?
    user.plugins.create(:name => 'events',
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end

page = Page.create(
  :title => 'Events',
  :link_url => '/events',
  :deletable => false,
  :position => ((Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1),
  :menu_match => '^/events(\/|\/.+?|)$'
)
Page.default_parts.each_with_index do |default_page_part, idx|
  page.parts.create(:title => default_page_part, :body => nil, :position => idx)
end
