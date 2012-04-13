require 'ostruct'
require 'active_support'
require 'refinery/calendar/configuration'
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
          subject.event_source = OpenStruct.public_method(:new)
          event = subject.new_event(x: 42, y: 'z')
          event.x.should == 42
          event.y.should == 'z'
        end
      end

      describe "#add_entry" do
        let(:entry) do
          OpenStruct.new(:starts => DateTime.parse('2011-01-01'))
        end

        let(:calendar) { CoreCalendar.find_or_create_by_id(1) }

        it "adds the entry to the calendar" do
          calendar.add_entry(entry)
          calendar.entries.should include entry
        end

        it "assigns its id to the entry's calendar_id" do
          calendar.add_entry(entry)
          entry.calendar_id.should == 1
        end
      end

      describe "#find_entry" do
        it "finds entries by id" do
          entry = OpenStruct.new(:id => 5)
          subject.add_entry(entry)
          subject.find_entry(5).should == entry
        end

        it "returns nil when the id is invalid" do
          subject.find_entry(999).should be_nil
        end
      end

      describe ".fetch" do
        it "returns a calendar from storage" do
          calendar = CoreCalendar.create!(:app => 'oxbow')
          CoreCalendar.fetch('oxbow').should == calendar
        end
      end
    end
  end
end
