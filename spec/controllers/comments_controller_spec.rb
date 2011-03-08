require 'spec_helper'

describe CommentsController do

  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'reply'" do
    it "should be successful" do
      get 'reply'
      response.should be_success
    end
  end

end
