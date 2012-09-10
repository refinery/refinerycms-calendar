# encoding: utf-8
require 'spec_helper'


describe "Regarding the mini calendar helper" do

  login_refinery_user

  context "when accessing the event index" do

    before :each do
      visit refinery.calendar_events_path
    end

    it("should have a mini-calendar") do
      page.should have_selector('#tcalendar')
    end

  end
end