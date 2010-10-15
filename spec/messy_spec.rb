require "spec_helper"

describe Messy do
  it "should set API URL" do
    Messy.api_url = "http://foobar.com"
    Messy.api_url.should == "http://foobar.com"
  end

  it "should raise error if API URL is not specified" do
    Messy.api_url = nil
    lambda { Messy.api_url }.should raise_error
  end

  it "should set API token" do
    Messy.api_token = "12345"
    Messy.api_token.should == "12345"
  end

  it "should raise error if API token is not specified" do
    Messy.api_token = nil
    lambda { Messy.api_token }.should raise_error
  end
end
