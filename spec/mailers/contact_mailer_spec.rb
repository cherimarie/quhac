require "rails_helper"

RSpec.describe ContactMailer, type: :mailer do
   describe 'new contact' do
    let(:mail) { ContactMailer.new_contact(name: 'Elvira, Queen of the Night', email: 'elvira@example.com', comments: 'This is super!') }

    it 'renders the subject' do
      expect(mail.subject).to eql('New contact recieved')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql(['quhac@gaycity.org'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['quhac@gaycity.org'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match('Elvira, Queen of the Night')
    end

    it 'assigns @email' do
      expect(mail.body.encoded).to match('elvira@example.com')
    end

    it 'assigns @comments' do
      expect(mail.body.encoded).to match('This is super!')
    end

    it 'does not blow up if no name is sent' do
      mail = ContactMailer.new_contact(email: 'elvira@example.com', comments: 'This is super!')
      expect(mail.subject).to eql('New contact recieved')
    end

    it 'does not blow up if no email is sent' do
      mail = ContactMailer.new_contact(name: 'Elvira, Queen of the Night', comments: 'This is super!')
      expect(mail.subject).to eql('New contact recieved')
    end
  end
end
