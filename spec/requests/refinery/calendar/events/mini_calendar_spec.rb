# encoding: utf-8
require 'spec_helper'


describe "Regarding the mini calendar helper" do

  login_refinery_user

  context "when accessing the event index" do

    before :each do
      Factory.create :event, :from => Date.today
      visit refinery.calendar_events_path
    end

    it("should have a mini-calendar") do
      page.should have_selector('#tcalendar')
    end

    it("should have events on the days with events") do
      page.should have_selector('#tcalendar .today.day-with-events')
    end

  end
end