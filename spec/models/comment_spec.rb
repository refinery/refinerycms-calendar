require 'spec_helper'
Dir[File.expand_path('../../../features/support/factories/*.rb', __FILE__)].each{|factory| require factory}

describe Comment do

  context "validations" do
    
    before(:each) do
      @attr = {
        :name => "Joe Sak",
        :comment => "All you haters suck my balls",
        :commentable_id => 1,
        :commentable_type => "Event"
      }
    end
    
    it "requires a name" do
      Comment.new(@attr.merge(:name => nil)).should_not be_valid
    end

    it "requires a comment" do
      Comment.new(@attr.merge(:comment => nil)).should_not be_valid
    end
    
    it "requires an commentable id" do
      Comment.new(@attr.merge(:commentable_id => nil)).should_not be_valid
    end
    
  end

end