require 'rails_helper'

RSpec.describe "UsersIndex", type: :request do
  describe "GET /users_index" do
    before do
      @user = FactoryBot.create(:user)
    end

    it "works! (now write some real specs)" do
      log_in_as(@user)
      get users_path
      assert_template 'users/index'
      # assert_select 'div.pagination'
      User.paginate(page: 1).each do |user|
        assert_select 'a[href=?]', user_path(user), text: user.name
      end
    end

    def log_in_as(user, password: 'password', remember_me: '1')
      post login_path, params: { session: { email: user.email,
                                            password: password,
                                            remember_me: remember_me } }
    end

  end
end
