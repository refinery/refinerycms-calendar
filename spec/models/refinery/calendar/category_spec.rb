require 'spec_helper'

module Refinery
  module Calendar
    describe Category do
      describe "validations" do
        subject do
          FactoryGirl.create(:category,
          :name => "Conferences")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:name) { should == "Conferences" }
      end

      describe "events" do
        it "has many events" do
          category = Factory(:category)
          category.should respond_to :events
        end
        it "can be assigned events" do
          category       = Factory(:category)
          event1         = Factory(:event)
          event2         = Factory(:event)
          category.events << event1
          category.events << event2
          category.events.should match_array [event1, event2]
        end
      end


    end
  end
end
