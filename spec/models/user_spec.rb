require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){User.new(name:"Example User", email:"user@example.com",
                      password: "foobar", password_confirmation: "foobar")}
  describe 'validate presence' do
    context 'when name is not empty' do
      it 'registration success' do
        expect(user).to be_valid
      end
    end
    context 'when name is empty' do
      it 'registration failure' do
        user.name = "  "
        expect(user).not_to be_valid
      end
    end
    context 'when email is empty' do
      it 'registration failure' do
        user.email = "  "
        expect(user).not_to be_valid
      end
    end
  end

  describe 'validate length' do
    context 'when name is long' do
      it 'registration failure' do
        user.name = "a" * 51
        expect(user).not_to be_valid
      end
    end
    context 'when email is long' do
      it 'registration failure' do
        user.email = "a" * 254 + "@example.com"
        expect(user).not_to be_valid
      end
    end
  end

  describe 'validate format' do
    context 'when correct email address' do
      it 'registration success' do
        valid_addresses = %w[user@example.com USER@EXAMPLE.COM A_US_ER@foo.bar.org
                            first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_addresse|
          user.email = valid_addresse
          expect(user).to be_valid
        end
      end
    end
    context 'when unjust email address' do
      it 'registration failure' do
        valid_addresses = %w[userexample.com user_at_foo.org yser.nameexample.com
                            foobar_baz.com foobar+baz.com]
        valid_addresses.each do |valid_addresse|
          user.email = valid_addresse
          expect(user).not_to be_valid
        end
      end
    end
  end

  describe 'validate unique' do
    context 'when duplicate email' do
      it 'registration failure' do
        dup_user = user.dup
        dup_user.email = user.email.upcase
        user.save
        expect(dup_user).not_to be_valid
      end
    end
    context 'when email is uppercase letter' do
      it 'email is downcase letter' do
        test_address = "TEST@example.com"
        user.email = test_address
        user.save
        expect(test_address.downcase).to eq(user.reload.email)
      end
    end
  end

  describe 'validate password' do
    context 'when password is not blank' do
      it 'registration failure' do
        user.password =  user.password_confirmation = " " * 6
        expect(user).not_to be_valid
      end
    end
    context 'when password is minmum length' do
      it 'registration failure' do
        user.password =  user.password_confirmation = "a" * 5
        expect(user).not_to be_valid
      end
    end
  end

  describe 'association' do
    it 'micropost destroy' do
      micropost = FactoryBot.create(:micropost)
      micropost.user_id = user.id
      user.save
      user.microposts.create!(content: "Lorem ipsum")
      user.destroy
      expect{ user.destroy }.to change {Micropost.count}.by(Micropost.count - 1)
    end
  end

end
