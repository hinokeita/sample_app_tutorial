require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  before do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  # エラー時の分かりやすさより速度を求めるならitの中にタイトルのテストも入れる。
  describe '#home' do
    before do
      get :home
    end

    it 'should get home' do
      expect(response).to have_http_status(:success)
    end

    it 'title correct' do
      assert_select "title", "Home | #{@base_title}"
    end

  end

  describe '#help' do
    before do
      get :help
    end

    it 'should get help' do
      expect(response).to have_http_status(:success)
    end

    it 'title correct' do
      assert_select "title", "Help | #{@base_title}"
    end

  end

  describe '#about' do
    before do
      get :about
    end

    it 'should get about' do
      expect(response).to have_http_status(:success)
    end

    it 'title correct' do
      assert_select "title", "About | #{@base_title}"
    end

  end

  describe '#contact' do
    before do
      get :contact
    end

    it 'should get contact' do
      expect(response).to have_http_status(:success)
    end

    it 'title correct' do
      assert_select "title", "Contact | #{@base_title}"
    end
  end

end
