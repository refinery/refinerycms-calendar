Given /^I have no events$/ do
  Event.delete_all
end

Given /^I (only )?have events titled "?([^\"]*)"?$/ do |only, titles|
  Event.delete_all if only
  titles.split(', ').each do |title|
    Factory(:event, :title => title)
  end
end

Then /^I should have ([0-9]+) events?$/ do |count|
  Event.count.should == count.to_i
end
