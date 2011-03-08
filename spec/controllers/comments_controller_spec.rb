require 'spec_helper'
Dir[File.expand_path('../../../features/support/factories/*.rb', __FILE__)].each{|factory| require factory}

describe CommentsController do

  describe "POST 'create'" do
    it "should be successful" do
      event = Factory(:event)
      post 'create', :id => event.id
      response.should be_success
    end
    
    it "should add a comment to an event" do
      event = Factory(:event)
      post 'create', :id => event.id, :comment => { :name => 'Joe Sak', :comment => 'This is my comment on the factory event' }
      response.should be_success
      Comment.last.event.should == event
    end
  end

  describe "POST 'reply'" do
    it "should be successful" do
      comment = Factory(:comment)
      post 'reply', :id => comment.id
      response.should be_success
    end
  end

end
