# Messy

API client for Jobstar Messaging Service.

## Install

Add the following line to your Gemfile and run `bundle install`:

    gem 'messy', :git => 'git@github.com:pederbl/messy.git'

Create an initializer file in `config/initializers` in which you'll set up the API url and token:

    Messy.api_url   = 'http://localhost:3000/api/v1'
    Messy.api_token = '12345678901234567890'

Save the file and restart your application.

## Sending an email

    @email = Messy::Email.new
    @email.subject    = "Hi there"
    @email.body       = "Just a test email"
    @email.recipients = "piotr.chmolowski@polcode.com"
    @email.from       = "Jobstar <jobstar@example.com>"

    Messy::Emailer.send(email)

## Sending an email with attachments

    @email.attachments << "/tmp/example/file.pdf"
    Messy::Emailer.send(email)

## Fetching incoming emails

    Messy::Emailer.fetch_incoming_emails(last_id)

## Fetching outgoing errors

    Messy::Emailer.fetch_outgoing_errors(last_id)
