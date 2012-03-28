require 'active_model'
require 'spec_no_rails_helper'
require 'calendar/event'

module Refinery
  module Calendar
    describe Event do
      before do
        @event = Event.new(:title => 'Something to be valid')
      end

      it "starts with blank optional attributes" do
        @event.starts.should be_nil
        @event.ends.should be_nil
        @event.body.should be_nil
      end

      it "is not valid with a blank title" do
        [nil, "", " "].each do |bad_title|
          @event.title = bad_title
          @event.should_not be_valid
        end
      end

      it "is valid with a non-blank title" do
        @event.title = "x"
        @event.should be_valid
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

      it "supports nutty rails date/time multiparams" do
        event = Event.new('starts(1i)' => '2012',
                          'starts(2i)' => '01',
                          'starts(3i)' => '01',
                          'starts(4i)' => '12',
                          'starts(5i)' => '30',
                          'ends(1i)' => '2012',
                          'ends(2i)' => '02',
                          'ends(3i)' => '01',
                          'ends(4i)' => '12',
                          'ends(5i)' => '30')
        event.starts.should == DateTime.parse('2012-01-01T12:30')
        event.ends.should == DateTime.parse('2012-02-01T12:30')
      end

      describe "#publish" do
        before do
          @calendar = stub(:calendar)
          @event.calendar = @calendar
        end

        it "adds the event to the calendar" do
          @calendar.should_receive(:add_entry).with(@event)
          @event.publish
        end

        describe "given an invalid event" do
          before do @event.title = nil end

          it "wont add the event to the calendar" do
            @calendar.should_not_receive(:add_entry)
            @event.publish
          end

          it "returns false" do
            @event.publish.should be_false
          end
        end
      end
    end
  end
end
