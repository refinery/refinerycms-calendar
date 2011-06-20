require 'spec_helper'
Dir[File.expand_path('../../../features/support/factories/*.rb', __FILE__)].each{|factory| require factory}

describe Event do

  def reset_event(options = {})
    @valid_attributes = {
      :id => 1,
      :title => "RSpec is great for testing too"
    }

    @event.destroy! if @event
    @event = Event.create!(@valid_attributes.update(options))
  end 

  context "validations" do
    
    before(:each) do
      reset_event
    end
    
    it "rejects empty title" do
      Event.new(@valid_attributes.merge(:title => "")).should_not be_valid
    end
    
    it "rejects a non-numerical ticket price" do
      Event.new({
        :title => "I have a bad ticket price",
        :ticket_price => "$25"
      }).should_not be_valid
      
      Event.new({
        :title => "I have a good ticket price",
        :ticket_price => "25"
      }).should be_valid
    
      Event.new({
        :title => "I have a decimal ticket price",
        :ticket_price => "25.00"
      }).should be_valid
    end
  end
  
  context "instance methods" do
    it "can find the next item" do
      event1 = Factory(:event)
      event2 = Factory(:event, :start_at => Time.now.advance(:days => 1), :end_at => Time.now.advance(:days => 1, :hours => 1))
      event1.next.should == event2
    end
    
    it "can find the previous item" do
      event1 = Factory(:event)
      event2 = Factory(:event, :start_at => Time.now.advance(:days => 1), :end_at => Time.now.advance(:days => 1, :hours => 1))
      event2.prev.should == event1
    end
  end
  
  context "categories" do
    it "has many categories" do
      event = Factory(:event)
      event.should respond_to :categories
    end
    
    it "can be assigned categories" do
      event = Factory(:event)
      cat1 = Factory(:event_category)
      cat2 = Factory(:event_category)
      
      event.categories << cat1
      event.categories << cat2
      
      event.categories.size.should be 2
    end     
    
  end

end
