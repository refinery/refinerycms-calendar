# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Calendar" do
    describe "Admin" do
      describe "venues" do
        login_refinery_user

        describe "venues list" do
          before(:each) do
            FactoryGirl.create(:venue, :name => "UniqueTitleOne")
            FactoryGirl.create(:venue, :name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.calendar_admin_venues_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
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

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Calendar::Venue.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Name can't be blank")
              Refinery::Calendar::Venue.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:venue, :name => "UniqueTitle") }

            it "should fail" do
              visit refinery.calendar_admin_venues_path

              click_link "Add New Venue"

              fill_in "Name", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Calendar::Venue.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:venue, :name => "A name") }

          it "should succeed" do
            visit refinery.calendar_admin_venues_path

            within ".actions" do
              click_link "Edit this venue"
            end

            fill_in "Name", :with => "A different name"
            click_button "Save"

            page.should have_content("'A different name' was successfully updated.")
            page.should have_no_content("A name")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:venue, :name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.calendar_admin_venues_path

            click_link "Remove this venue forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Calendar::Venue.count.should == 0
          end
        end

        context "with translations" do

          before(:each) do
            Globalize.locale = :en
            Refinery::I18n.stub(:frontend_locales).and_return([:en, :es])
            visit refinery.calendar_admin_venues_path
          end

          describe "add a venue with name for default locale" do

            before do
              click_link "Add New Venue"
              fill_in "Name", :with => "Venue"
              click_button "Save"
              @v = Refinery::Calendar::Venue.find_by_name("Venue")
            end

            it "succeeds" do
              page.should have_content("'Venue' was successfully added.")
              Refinery::Calendar::Venue.count.should eq(1)
            end

            it "shows locale flag for venue" do
              within "#venue_#{@v.id}" do
                page.should have_css("img[src='/assets/refinery/icons/flags/en.png']")
              end
            end

          end

          describe "add a venue with name only for secondary locale" do

            let(:es_venue_name) { 'Lugar' }

            before do
              click_link "Add New Venue"
              within "#switch_locale_picker" do
                click_link "Es"
              end
              fill_in "Name", :with => es_venue_name
              click_button "Save"
              @v = Refinery::Calendar::Venue.find_by_name(es_venue_name)
            end

            it "succeeds" do
              page.should have_content("'#{es_venue_name}' was successfully added.")
              Refinery::Calendar::Venue.count.should eq(1)
            end

            it "shows name in secondary locale" do
              within "#venue_#{@v.id}" do
                page.should have_content(es_venue_name)
              end
            end

            it "shows locale flag for venue" do
              within "#venue_#{@v.id}" do
                page.should have_css("img[src='/assets/refinery/icons/flags/es.png']")
              end
            end

            it "does not show locale flag for primary locale" do
              within "#venue_#{@v.id}" do
                page.should_not have_css("img[src='/assets/refinery/icons/flags/en.png']")
              end
            end

          end

          context "with a venue in both locales" do

            let!(:venue) do
              _venue = Globalize.with_locale(:en) { FactoryGirl.create(:venue, :name => "UniqueNameOne") }
              Globalize.with_locale(:es) do
                _venue.name = 'Nombre'
                _venue.save
              end
              _venue
            end

            before(:each) do
              visit refinery.calendar_admin_venues_path
            end

            it "shows both locale flags for venue" do
              within "#venue_#{venue.id}" do
                page.should have_css("img[src='/assets/refinery/icons/flags/en.png']")
                page.should have_css("img[src='/assets/refinery/icons/flags/es.png']")
              end
            end

            describe "edit the venue in english" do

              it "succeeds" do
                within "#venue_#{venue.id}" do
                  click_link("En")
                end
                current_path.should == refinery.edit_calendar_admin_venue_path(venue)
                fill_in "Name", :with => "New Venue Name"
                click_button "Save"

                page.should_not have_content(venue.name)
                page.should have_content("'New Venue Name' was successfully updated.")
              end
            end

            describe "edit the venue in secondary locale" do
              it "succeeds" do
                within "#venue_#{venue.id}" do
                  click_link("Es")
                end

                fill_in "Name", :with => "Nuevo nombre del lugar"
                click_button "Save"

                page.should_not have_content(venue.name)
                page.should have_content("'Nuevo nombre del lugar' was successfully updated.")
              end
            end

          end

        end

      end
    end
  end
end
