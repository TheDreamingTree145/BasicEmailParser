class Email < ApplicationRecord

  def self.new_from_email(email)
    new_email = Email.new
    new_email.sent = email.match(/Date: (.*)/)[1]
    new_email.receiver = email.match(/Delivered-To: (.*)/)[1]
    new_email.sender = email.match(/From:\s(.*)<(.*)>/)[2]
    if email.match(/Cc:/)
      new_email.cc = email.match(/Cc:\s\w*\s\w*\s(.*)/)[1].gsub(/[<>]/, "")
    end
    new_email.subject = email.match(/Subject: (.*)/)[1]
    new_email.content = email.match(/Content-Type: text\/plain; charset="UTF-8"\s(.*?)\--\b/m)[1]
    new_email.save
    new_email
  end

end
