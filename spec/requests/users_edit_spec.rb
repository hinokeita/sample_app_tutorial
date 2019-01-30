require 'rails_helper'

RSpec.describe "UserEdits", type: :request do
  describe "GET /user_edits" do
    before do
      debugger
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:user,name:"test",email:"duchess@example.gov")
    end

    it "works! (now write some real specs)" do
      log_in_as(@user)
      get edit_user_path(@user)
      assert_template 'users/edit'
      patch user_path(@user), params: { user: { name:  "",
                                             email: "foo@invalid",
                                             password:              "foo",
                                             password_confirmation: "bar" } }

      assert_template 'users/edit'
    end

    it "successful edit" do
      log_in_as(@user)
      get edit_user_path(@user)
      assert_template 'users/edit'
      name  = "Foo Bar"
      email = "foo@bar.com"
      patch user_path(@user), params: { user: { name:  name,
                                               email: email,
                                               password:              "",
                                               password_confirmation: "" } }
      expect(flash).not_to be_empty
      assert_redirected_to @user
      @user.reload
      assert_equal name,  @user.name
      assert_equal email, @user.email

    end
  end

  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
end
