# encoding: utf-8
require 'spec_helper'

describe "Date filters on index" do

  login_refinery_user


  before :each do
    Factory.create :event, title: "tomorrow event", from: Date.tomorrow
    Factory.create :event, title: "future event", from: 10.days.from_now
  end

  context "when accessing the event index" do

    before :each do
      visit refinery.calendar_events_path
    end

    it("should list all the events") do
      page.should have_content 'tomorrow event'
      page.should have_content 'future event'
    end

  end

  context "when filtering the events for tomorrow" do

    before :each do
      visit refinery.calendar_events_path(date: Date.tomorrow)
    end

    it("should list only the event for tomorrow") do
      page.should have_content 'tomorrow event'
      page.should_not have_content 'future event'
    end

  end

  context "when filtering the events for yesterday" do

    before :each do
      visit refinery.calendar_events_path(date: Date.yesterday)
    end

    it("should list no event") do
      page.should_not have_content 'tomorrow event'
      page.should_not have_content 'future event'
    end

  end

end