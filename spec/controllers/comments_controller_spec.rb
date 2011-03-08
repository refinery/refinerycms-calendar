require 'spec_helper'

describe CommentsController do

  describe "POST 'create'" do
    it "should be successful" do
      post 'create'
      response.should be_success
    end
  end

  describe "POST 'reply'" do
    it "should be successful" do
      comment = Comment.create!
      post 'reply', :id => comment.id
      response.should be_success
    end
  end

end
