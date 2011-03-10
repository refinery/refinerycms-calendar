require 'spec_helper'
Dir[File.expand_path('../../../features/support/factories/*.rb', __FILE__)].each{|factory| require factory}

describe EventsController do

  describe "GET 'index' RSS" do
    it "should be successful" do
      get 'index', :format => :rss
      response.should be_success
    end
    
  end
  
end