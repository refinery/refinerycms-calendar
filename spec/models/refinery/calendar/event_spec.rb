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

      it "supports reading and writing a calendar reference" do
        calendar = Object.new
        @event.calendar = calendar
        @event.calendar.should == calendar
      end

      it "supports setting attributes in the initializer" do
        time = DateTime.now
        end_time = DateTime.new(2045,1,1)
        calendar = Object.new
        event = Event.new(:title => 'foo',
                          :body => '<html>bar</html>',
                          :starts => time,
                          :ends => end_time,
                          :calendar => calendar)
        event.title.should == 'foo'
        event.body.should == '<html>bar</html>'
        event.starts.should == time
        event.ends.should == end_time
        event.calendar.should == calendar
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
