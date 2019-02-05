require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  describe "GET /password_resets" do
    before do
      ActionMailer::Base.deliveries.clear
      @user = FactoryBot.create(:user)
    end
    it "works! (now write some real specs)" do
      get new_password_reset_path
          assert_template 'password_resets/new'
          # メールアドレスが無効
          post password_resets_path, params: { password_reset: { email: "" } }
          expect(flash).not_to be_empty
          assert_template 'password_resets/new'
          # メールアドレスが有効
          post password_resets_path,
               params: { password_reset: { email: @user.email } }
          assert_equal 1, ActionMailer::Base.deliveries.size
          expect(flash).not_to be_empty
          assert_redirected_to root_url
          # パスワード再設定フォームのテスト
          user = assigns(:user)
          # メールアドレスが無効
          get edit_password_reset_path(user.reset_token, email: "")
          assert_redirected_to root_url
          # 無効なユーザー
          user.toggle!(:activated)
          get edit_password_reset_path(user.reset_token, email: user.email)
          assert_redirected_to root_url
          user.toggle!(:activated)
          # メールアドレスが有効で、トークンが無効
          get edit_password_reset_path('wrong token', email: user.email)
          assert_redirected_to root_url
          # メールアドレスもトークンも有効
          get edit_password_reset_path(user.reset_token, email: user.email)
          assert_template 'password_resets/edit'
          assert_select "input[name=email][type=hidden][value=?]", user.email
          # 無効なパスワードとパスワード確認
          patch password_reset_path(user.reset_token),
                params: { email: user.email,
                          user: { password:              "foobaz",
                                  password_confirmation: "barquux" } }
          assert_select 'div#error_explanation'
          # パスワードが空
          patch password_reset_path(user.reset_token),
                params: { email: user.email,
                          user: { password:              "",
                                  password_confirmation: "" } }
          assert_select 'div#error_explanation'
          # 有効なパスワードとパスワード確認
          patch password_reset_path(user.reset_token),
                params: { email: user.email,
                          user: { password:              "foobaz",
                                  password_confirmation: "foobaz" } }
          expect(flash).not_to be_empty
          assert_redirected_to user
    end
  end
end
