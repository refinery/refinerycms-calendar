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
    end
  end
end
