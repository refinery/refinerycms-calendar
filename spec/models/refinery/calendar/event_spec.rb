require 'spec_helper'

module Refinery
  module Calendar
    describe Event do
      describe "validations" do
        subject do
          FactoryGirl.create(:event, :title => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:title) { should == "Refinery CMS" }

      end

      describe "upcoming events" do

        before :each do

          FactoryGirl.create(:event, starts_at: 2.hours.ago)
          FactoryGirl.create(:event, starts_at: 2.hours.from_now)
          FactoryGirl.create(:event, starts_at: 2.days.from_now)
          FactoryGirl.create(:event, starts_at: 2.weeks.from_now)

        end

        subject { Event.upcoming }

        its(:length) { should == 3 }

      end

      describe "tomorrow events" do

        before :each do

          FactoryGirl.create(:event, starts_at: Date.tomorrow - 2.hours)
          FactoryGirl.create(:event, starts_at: Date.tomorrow.beginning_of_day)
          FactoryGirl.create(:event, starts_at: Date.tomorrow + 2.hours)
          FactoryGirl.create(:event, starts_at: Date.tomorrow + 6.hours)
          FactoryGirl.create(:event, starts_at: Date.tomorrow + 12.hours)
          FactoryGirl.create(:event, starts_at: Date.yesterday, ends_at: 2.days.from_now)
          FactoryGirl.create(:event, starts_at: Date.tomorrow + 2.days)

        end

        subject { Event.on_day(Date.tomorrow) }

        its(:length) { should == 5 }

      end

    end
  end
end
