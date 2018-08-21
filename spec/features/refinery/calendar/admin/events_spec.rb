# encoding: utf-8
require "spec_helper"

module Refinery
  module Calendar
    module Admin
      describe Event, type: :feature do
        refinery_login

        describe "events list" do
          before(:each) do
            FactoryBot.create(:event, :title => "UniqueTitleOne")
            FactoryBot.create(:event, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.calendar_admin_events_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
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
              click_button "Save"

              expect(page).to have_content("'This is a test of the first string field' was successfully added.")
              expect(Refinery::Calendar::Event.count).to eq(1)
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              expect(page).to have_content("Title can't be blank")
              expect(Refinery::Calendar::Event.count).to eq(0)
            end
          end

          context "duplicate" do
            before(:each) { FactoryBot.create(:event, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.calendar_admin_events_path

              click_link "Add New Event"

              fill_in "Title", :with => "UniqueTitle"
              click_button "Save"

              expect(page).to have_content("There were problems")
              expect(Refinery::Calendar::Event.count).to eq(1)
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryBot.create(:event, :title => "A title") }

          it "should succeed" do
            visit refinery.calendar_admin_events_path

            within ".actions" do
              click_link "Edit this event"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            expect(page).to have_content("'A different title' was successfully updated.")
            expect(page).to have_no_content("A title")
          end
        end

        describe "destroy" do
          before(:each) { FactoryBot.create(:event, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.calendar_admin_events_path

            click_link "Remove this event forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::Calendar::Event.count).to eq(0)
          end
        end

      end
    end
  end
end
