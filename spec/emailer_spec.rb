require "spec_helper"

describe Messy::Emailer do
  before(:each) do
    Messy.api_url = 'http://localhost:3000/api/v1'

    @email = Messy::Email.new
    @email.subject    = "Hi there"
    @email.body       = "Just a test email"
    @email.recipients = "piotr.chmolowski@polcode.com"
    @email.from       = "jobstar@example.com"
  end

  it "should send an email" do
    result = Messy::Emailer.send(@email)
    result.should be_a(Hash)
  end

  it "should send an email with an attachment" do
    @email.attachments["sample_attachment.pdf"] = File.read(File.dirname(__FILE__) + "/fixtures/sample_attachment.pdf")

    result = Messy::Emailer.send(@email)
    result.should be_a(Hash)
  end

  it "should get incoming emails" do
    Messy::Emailer.fetch_incoming_emails(1).should be_an(Array)
  end

  it "should return errors when trying to send an email without sender address" do
    @email.from = nil

    begin
      Messy::Emailer.send(@email)
    rescue Messy::InvalidData => e
      errors = ActiveSupport::JSON.decode(e.to_s)
      errors.should be_a(Hash)
      errors["from"].should == "from is required"
    end
  end

  it "should return errors when trying to send an email without recipient address" do
    @email.recipients = nil

    begin
      Messy::Emailer.send(@email)
    rescue Messy::InvalidData => e
      errors = ActiveSupport::JSON.decode(e.to_s)
      errors.should be_a(Hash)
      errors["recipients"].should == "recipients is required"
    end
  end
end
