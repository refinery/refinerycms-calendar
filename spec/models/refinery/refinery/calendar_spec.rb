require 'calendar'

module Refinery
  describe Calendar do
    it "has an empty title" do
      subject.title.should be_nil
    end
  end
end
