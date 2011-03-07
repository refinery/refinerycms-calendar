require 'spec_helper'

describe Event do

  def reset_event(options = {})
    @valid_attributes = {
      :id => 1,
      :title => "RSpec is great for testing too"
    }

    @event.destroy! if @event
    @event = Event.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_event
  end

  context "validations" do
    
    it "rejects empty title" do
      Event.new(@valid_attributes.merge(:title => "")).should_not be_valid
    end

    it "rejects non unique title" do
      # as one gets created before each spec by reset_event
      Event.new(@valid_attributes).should_not be_valid
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
      #TODO: test next & previous methods
    end
    
    it "can find the previous item" do
      #TODO: test next & previous methods
    end
  end

end