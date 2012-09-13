require 'spec_helper'

module Refinery
  module Calendar
    describe Event do
      describe "valid event" do
        subject do
          FactoryGirl.create(:event,
          :title => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:title) { should == "Refinery CMS" }
      end
      describe "invalid event" do
        subject do
            FactoryGirl.build(:event,
            :start_at => '2012-10-01 10:00:00',
            :end_at => '2012-09-30 12:00:00')
        end

        it "should be in error" do
          subject.valid?
          subject.errors[:start_at].should include('must come before the end date')
        end
      end
    end
  end
end
