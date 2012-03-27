require 'spec_no_rails_helper'
require 'calendar/core_calendar'

module Refinery
  module Calendar
    describe CoreCalendar do
      it "has an empty title" do
        subject.title.should be_nil
      end

      it "can have its title configured" do
        Calendar.configure do |config|
          config.title = 'Refinery Calendar'
        end
        subject.title.should == 'Refinery Calendar'
      end

      it "has no entries" do
        subject.should have(0).entries
      end

      describe "#new_event" do
        before do
          @new_event = OpenStruct.new
          subject.event_source = -> { @new_event }
        end

        it "returns a new event" do
          subject.new_event.should == @new_event
        end

        it "accepts an attribute hash on behalf of the event maker" do
          event_source = MiniTest::Mock.new
          event_source.expect(:call, @new_event, [{x: 42, y: 'z'}])
          subject.event_source = event_source
          subject.new_event(x: 42, y: 'z')
          event_source.verify
        end
      end

      describe "#add_entry" do
        it "adds the entry to the calendar" do
          entry = Object.new
          subject.add_entry(entry)
          subject.entries.should include entry
        end
      end
    end
  end
end
