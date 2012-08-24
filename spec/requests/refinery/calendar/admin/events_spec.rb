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
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Calendar::Event.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Title can't be blank")
              Refinery::Calendar::Event.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:event, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.calendar_admin_events_path

              click_link "Add New Event"

              fill_in "Title", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Calendar::Event.count.should == 1
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

        context "with translations" do

          before(:each) do
            Globalize.locale = :en
            Refinery::I18n.stub(:frontend_locales).and_return([:en, :es])
            event_page = Factory.create(:page, :link_url => "/event", :title => "Event")
            Globalize.with_locale(:es) do
              event_page.title = 'Evento'
              event_page.save
            end
            visit refinery.calendar_admin_events_path
          end

          describe "add a event with title for default locale" do
            before do
              click_link "Add New Event"
              fill_in "Title", :with => "Event"
              fill_in "From", :with => I18n.l(1.day.from_now, :format => :long)
              fill_in "To", :with => I18n.l(2.day.from_now, :format => :long)
              click_button "Save"
              @e = Refinery::Calendar::Event.find_by_title("Event")
            end

            it "succeeds" do
              page.should have_content("'Event' was successfully added.")
              Refinery::Calendar::Event.count.should eq(1)
            end

            it "shows locale flag for event" do
              within "#event_#{@e.id}" do
                page.should have_css("img[src='/assets/refinery/icons/flags/en.png']")
              end
            end

            it "shows up in event page for default locale" do
              visit refinery.calendar_events_path
              page.should have_selector("#event_#{@e.id}")
            end

            it "does not show up in event page for secondary locale" do
              visit refinery.calendar_events_path(:locale => :es)
              page.should_not have_selector("#event_#{@e.id}")
            end
          end

          describe "add a event with title only for secondary locale" do

            let(:es_event_title) { 'Evento' }

            before do
              click_link "Add New Event"
              within "#switch_locale_picker" do
                click_link "Es"
              end
              fill_in "Title", :with => es_event_title
              fill_in "From", :with => I18n.l(1.day.from_now, :format => :long)
              fill_in "To", :with => I18n.l(2.day.from_now, :format => :long)
              click_button "Save"
              @e = Refinery::Calendar::Event.find_by_title(es_event_title)
            end

            it "succeeds" do
              page.should have_content("'#{es_event_title}' was successfully added.")
              Refinery::Calendar::Event.count.should eq(1)
            end

            it "shows title in secondary locale" do
              within "#event_#{@e.id}" do
                page.should have_content(es_event_title)
              end
            end

            it "shows locale flag for event" do
              within "#event_#{@e.id}" do
                page.should have_css("img[src='/assets/refinery/icons/flags/es.png']")
              end
            end

            it "does not show locale flag for primary locale" do
              within "#event_#{@e.id}" do
                page.should_not have_css("img[src='/assets/refinery/icons/flags/en.png']")
              end
            end

            it "does not show up in event page for default locale" do
              visit refinery.calendar_events_path
              page.should_not have_selector("#event_#{@e.id}")
            end

            it "shows up in blog page for secondary locale" do
              visit refinery.calendar_events_path(:locale => :es)
              page.should have_selector("#event_#{@e.id}")
            end

          end

          context "with a event in both locales" do

            let!(:event) do
              _event = Globalize.with_locale(:en) { FactoryGirl.create(:event,
                                                      :title => "UniqueTitleOne",
                                                      :from => 1.day.from_now,
                                                      :to => 2.day.from_now) }
              Globalize.with_locale(:es) do
                _event.title = 'Título unico uno'
                _event.save
              end
              _event
            end

            before(:each) do
              visit refinery.calendar_admin_events_path
            end

            it "shows both locale flags for event" do
              within "#event_#{event.id}" do
                page.should have_css("img[src='/assets/refinery/icons/flags/en.png']")
                page.should have_css("img[src='/assets/refinery/icons/flags/es.png']")
              end
            end

            describe "edit the event in english" do
              it "succeeds" do

                within "#event_#{event.id}" do
                  click_link("En")
                end
                current_path.should == refinery.edit_calendar_admin_event_path(event)
                fill_in "Title", :with => "New Event Title"
                click_button "Save"

                page.should_not have_content(event.title)
                page.should have_content("'New Event Title' was successfully updated.")
              end
            end

            describe "edit the event in secondary locale" do
              it "succeeds" do
                within "#event_#{event.id}" do
                  click_link("Es")
                end

                fill_in "Title", :with => "Nuevo título del evento"
                click_button "Save"

                page.should_not have_content(event.title)
                page.should have_content("'Nuevo título del evento' was successfully updated.")
              end
            end

          end

        end

      end
    end
  end
end
