require 'rails_helper'

RSpec.describe "UsersLogin", type: :request do
  describe "GET /users_login" do
    it "works! (now write some real specs)" do
      get login_path
      assert_template 'sessions/new'
      post login_path, params:{ session: { email: "", password: ""} }
      assert_template 'sessions/new'
      expect(flash).not_to be_empty
      get root_path
      expect(flash).to be_empty
    end
  end
end
