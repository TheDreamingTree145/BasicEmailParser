class Email < ApplicationRecord

  def self.new_from_email(email)
    new_email = Email.new
    new_email.attributes.keys.each do |key|
      case key
      when 'sent'
        new_email[key] = email.match(/Date: (.*)/)[1]
        break
      when 'receiver'
        new_email[key] = email.match(/Delivered-To: (.*)/)[1]
      when 'sender'
        new_email[key] = email.match(/From:\s(.*)<(.*)>/)[2]
      when 'cc'
        if email.match(/Cc:/)
          new_email[key] = email.match(/Cc:\s\w*\s\w*\s(.*)/)[1].gsub(/[<>]/, "")
        end
      when 'subject'
        new_email[key] = email.match(/Subject: (.*)/)[1]
      when 'content'
        new_email[key] = email.match(/Content-Type: text\/plain; charset="UTF-8"\s(.*?)\--\b/m)[1]
      end
    end
    new_email.save
    new_email
  end

end
