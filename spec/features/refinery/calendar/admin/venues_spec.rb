# encoding: utf-8
require "spec_helper"

module Refinery
  module Calendar
    module Admin
      describe Venue, type: :feature do
        refinery_login

        describe "venues list" do
          before(:each) do
            FactoryBot.create(:venue, :name => "UniqueTitleOne")
            FactoryBot.create(:venue, :name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.calendar_admin_venues_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.calendar_admin_venues_path

            click_link "Add New Venue"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name", :with => "This is a test of the first string field"
              click_button "Save"

              expect(page).to have_content("'This is a test of the first string field' was successfully added.")
              expect(Refinery::Calendar::Venue.count).to eq(1)
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              expect(page).to have_content("Name can't be blank")
              expect(Refinery::Calendar::Venue.count).to eq(0)
            end
          end

          context "duplicate" do
            before(:each) { FactoryBot.create(:venue, :name => "UniqueTitle") }

            it "should fail" do
              visit refinery.calendar_admin_venues_path

              click_link "Add New Venue"

              fill_in "Name", :with => "UniqueTitle"
              click_button "Save"

              expect(page).to have_content("There were problems")
              expect(Refinery::Calendar::Venue.count).to eq(1)
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryBot.create(:venue, :name => "A name") }

          it "should succeed" do
            visit refinery.calendar_admin_venues_path

            within ".actions" do
              click_link "Edit this venue"
            end

            fill_in "Name", :with => "A different name"
            click_button "Save"

            expect(page).to have_content("'A different name' was successfully updated.")
            expect(page).to have_no_content("A name")
          end
        end

        describe "destroy" do
          before(:each) { FactoryBot.create(:venue, :name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.calendar_admin_venues_path

            click_link "Remove this venue forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::Calendar::Venue.count).to eq(0)
          end
        end

      end
    end
  end
end
