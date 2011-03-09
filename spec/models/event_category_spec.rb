require 'spec_helper'
Dir[File.expand_path('../../../features/support/factories/*.rb', __FILE__)].each{|factory| require factory}

describe EventCategory do
  before(:each) do
    @attr = Factory(:event_category).attributes
  end

  context "validations" do
    
    it "requires a name" do
      EventCategory.new(@attr.merge(:name => nil)).should_not be_valid
    end
    
  end
  
  context "events" do
    it "can associate with many events" do
      event1 = Factory(:event)
      event2 = Factory(:event)
      category = Factory(:event_category)
      
      category.events << event1
      category.events << event2
      
      category.events.size.should be 2
    end
  end
end
