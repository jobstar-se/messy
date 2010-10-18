require "spec_helper"

describe Messy::Emailer do
  before(:each) do
    Messy.api_url = 'http://localhost:3000/api/v1'

    @email = Messy::Email.new
    @email.subject    = "Hi there"
    @email.body       = "Just a test email"
    @email.recipients = "piotr.chmolowski@polcode.com"
    @email.from       = "Jobstar <jobstar@example.com>"
  end

  it "should send an email" do
    Messy::Emailer.send(@email)
  end

  it "should send an email with an attachment" do
    @email.attachments << File.dirname(__FILE__) + "/fixtures/sample_attachment.pdf"

    Messy::Emailer.send(@email)
  end
end
