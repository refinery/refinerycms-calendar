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
    
  end

end