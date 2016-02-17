class ContactMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_contact(name: nil, email: nil, comments:)
    @name = name
    @email = email
    @comments = comments
    mail(to: "quhac@gaycity.org", subject: "New contact recieved")
  end
end