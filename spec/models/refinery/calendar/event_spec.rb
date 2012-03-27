require 'spec_no_rails_helper'
require 'calendar/event'

module Refinery
  module Calendar
    describe Event do
      before do
        @event = Event.new
      end

      it "starts with blank attributes" do
        @event.title.should be_nil
        @event.starts.should be_nil
        @event.ends.should be_nil
        @event.body.should be_nil
      end

      it "supports reading and writing a title" do
        @event.title = 'foo'
        @event.title.should == 'foo'
      end

      it "supports reading and writing starts" do
        time = DateTime.now
        @event.starts = time
        @event.starts.should == time
      end

      it "supports reading and writing ends" do
        time = DateTime.now
        @event.ends = time
        @event.ends.should == time
      end

      it "supports reading and writing a body" do
        @event.body = '<html>foo</html>'
        @event.body.should == '<html>foo</html>'
      end

      it "supports reading and writing a blog reference" do
        calendar = Object.new
        @event.calendar = calendar
        @event.calendar.should == calendar
      end

      describe "#publish" do
        before do
          @calendar = MiniTest::Mock.new
          @event.calendar = @calendar
        end

        after do
          @calendar.verify
        end

        it "adds the event to the calendar" do
          @calendar.expect :add_entry, nil, [@event]
          @event.publish
        end
      end
    end
  end
end
