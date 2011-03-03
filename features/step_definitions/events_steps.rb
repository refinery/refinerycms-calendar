Given /^I have no events$/ do
  Events.delete_all
end

Given /^I (only )?have events titled "?([^\"]*)"?$/ do |only, titles|
  Events.delete_all if only
  titles.split(', ').each do |title|
    Events.create(:title => title)
  end
end

Then /^I should have ([0-9]+) events?$/ do |count|
  Events.count.should == count.to_i
end
