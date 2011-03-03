require 'spec_helper'

describe Events do

  def reset_events(options = {})
    @valid_attributes = {
      :id => 1,
      :title => "RSpec is great for testing too"
    }

    @events.destroy! if @events
    @events = Events.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_events
  end

  context "validations" do
    
    it "rejects empty title" do
      Events.new(@valid_attributes.merge(:title => "")).should_not be_valid
    end

    it "rejects non unique title" do
      # as one gets created before each spec by reset_events
      Events.new(@valid_attributes).should_not be_valid
    end
    
  end

end