require 'spec_helper'

module Refinery
  module Calendar
    describe Venue, type: :model do
      describe "validations" do
        subject do
          FactoryBot.create(:venue,
          :name => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:name) { should == "Refinery CMS" }
      end
    end
  end
end
