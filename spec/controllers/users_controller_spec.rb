require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    before do
      @users = FactoryBot.create(:user,name:"user1")
      @other_user = FactoryBot.create(:user,name:"user2",email:"example2@gmail.com")
    end
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "test" do
      get :index
      assert_redirected_to login_path
    end

  end

end
