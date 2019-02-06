require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user){ FactoryBot.create(:user) }
  let(:micropost){ user.microposts.build(content: "Lorem ipsum") }

  describe 'validate' do
    it 'be valid' do
      expect(micropost).to be_valid
    end
  end

  describe 'validate presence' do
    context 'when user id is nil' do
      it 'registration failure' do
        micropost.user_id = nil
        expect(micropost).not_to be_valid
      end
    end
    context 'when content is nil' do
      it 'registration failure' do
        micropost.content = nil
        expect(micropost).not_to be_valid
      end
    end
  end

  describe 'validate maximum' do
    context 'when content is over 140 characters' do
      it 'registration failure' do
        micropost.content = "a" * 141
        expect(micropost).not_to be_valid
      end
    end
  end

end
