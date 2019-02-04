require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "account_activation" do
    it "renders the headers" do
        user = FactoryBot.create(:user)
        user.activation_token = User.new_token
        mail = UserMailer.account_activation(user)
        assert_equal "Account activation", mail.subject
        assert_equal [user.email], mail.to
        assert_equal ["noreply@example.com"], mail.from
        assert_match user.name,               mail.body.encoded
        assert_match user.activation_token,   mail.body.encoded
        assert_match CGI.escape(user.email),  mail.body.encoded
    end

    it "renders the body" do
      user = FactoryBot.create(:user)
      user.activation_token = User.new_token
      mail = UserMailer.account_activation(user)
      expect(mail.body.encoded).to match("Hi")
    end
  end

  # describe "password_reset" do
  #   let(:mail) { UserMailer.password_reset }
  #
  #   it "renders the headers" do
  #     expect(mail.subject).to eq("Password reset")
  #     expect(mail.to).to eq(["to@example.org"])
  #     expect(mail.from).to eq(["noreply@example.com"])
  #   end
  #
  #   it "renders the body" do
  #     expect(mail.body.encoded).to match("Hi")
  #   end
  # end

end
