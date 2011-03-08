require 'spec_helper'
Dir[File.expand_path('../../../features/support/factories/*.rb', __FILE__)].each{|factory| require factory}

describe Comment do
  
  before(:each) do
    @attr = {
      :name => "Joe Sak",
      :comment => "All you haters suck my balls",
      :commentable_id => 1,
      :commentable_type => "Event"
    }
  end

  context "validations" do
    
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
  
  context "commentable comments" do
    it "can be commented on" do
      comment = Factory(:comment)
      comment.should respond_to :comments 
    end
    
    it "responds to replies" do
      comment = Factory(:comment)
      comment.should respond_to :replies
    end
    
    it "can only thread to 1 level" do
      comment = Factory(:comment)
      reply = comment.comments.create({ :name => "Replier", :comment => "This is a reply. No commenting allowed" })
      reply.commentable?.should_not be true
    end
  end

end