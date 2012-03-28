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

      describe "#entries" do
        def stub_entry_with_date(date)
          OpenStruct.new(:starts => DateTime.parse(date))
        end

        it "is sorted in chronological order" do
          newest = stub_entry_with_date("2011-09-11")
          oldest = stub_entry_with_date("2011-09-09")
          middle = stub_entry_with_date("2011-09-10")
          subject.add_entry(oldest)
          subject.add_entry(newest)
          subject.add_entry(middle)
          subject.entries.should == [oldest, middle, newest]
        end
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
          entry = OpenStruct.new(:starts => DateTime.parse('2011-01-01'))
          subject.add_entry(entry)
          subject.entries.should include entry
        end
      end
    end
  end
end
