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

    Messy::Emailer.send(@email)
  end

  it "should get incoming emails" do
    Messy::Emailer.fetch_incoming_emails(1).should be_an(Array)
  end

  it "should get outgoing errors" do
    Messy::Emailer.fetch_outgoing_errors(1).should be_an(Array)
  end
end
