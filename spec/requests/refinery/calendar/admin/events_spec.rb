# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Calendar" do
    describe "Admin" do
      describe "events" do
        login_refinery_user

        describe "events list" do
          before(:each) do
            FactoryGirl.create(:event, :title => "UniqueTitleOne")
            FactoryGirl.create(:event, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.calendar_admin_events_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.calendar_admin_events_path

            click_link "Add New Event"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              fill_in "From", :with => "2011-01-01 12:00:00"
              fill_in "To", :with => "2011-01-01 15:00:00"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Calendar::Event.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail with no title" do
              click_button "Save"

              page.should have_content("Title can't be blank")
              Refinery::Calendar::Event.count.should == 0
            end

            it "should fail with no start date" do
              fill_in "Title", :with => "My Birthday"
              click_button "Save"

              page.should have_content("From can't be blank")
              Refinery::Calendar::Event.count.should == 0
            end

            it "should fail with no end date" do
              fill_in "Title", :with => "My Birthday"
              fill_in "From", :with => "2011-08-18 00:00:00"
              click_button "Save"

              page.should have_content("To can't be blank")
              Refinery::Calendar::Event.count.should == 0
            end

          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:event, :title => "A title") }

          it "should succeed" do
            visit refinery.calendar_admin_events_path

            within ".actions" do
              click_link "Edit this event"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            page.should have_content("'A different title' was successfully updated.")
            page.should have_no_content("A title")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:event, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.calendar_admin_events_path

            click_link "Remove this event forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Calendar::Event.count.should == 0
          end
        end

      end
    end
  end
end
