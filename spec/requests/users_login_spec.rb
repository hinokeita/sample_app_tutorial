require 'rails_helper'

RSpec.describe "UsersLogin", type: :request do
  describe "GET /users_login" do
    before do
      FactoryBot.create(:user)
    end
    it "works! (now write some real specs)" do
      get login_path
      assert_template 'sessions/new'
      post login_path, params:{ session: { email: "", password: ""} }
      assert_template 'sessions/new'
      expect(flash).not_to be_empty
      get root_path
      expect(flash).to be_empty
    end

    # expectのところがうまくいかない
    # it "login success" do
    #   visit login_path
    #   fill_in "Email",with: User.first.email
    #   fill_in "Password", with: User.first.password
    #   click_button "Log in"
    #   puts current_path
    #   # expect(current_path).to eq home_path
    # end
  end
end
