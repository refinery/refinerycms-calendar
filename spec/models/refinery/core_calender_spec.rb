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

      describe "#new_entry" do
        before do
          @new_entry = OpenStruct.new
          subject.entry_source = -> { @new_entry }
        end

        it "returns a new entry" do
          subject.new_entry.should == @new_entry
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
