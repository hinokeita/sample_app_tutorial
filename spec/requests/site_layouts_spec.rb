require 'rails_helper'

RSpec.describe "SiteLayouts", type: :request do
  describe "GET /root" do
    it "lauout links" do
      get root_path
      assert_template 'static_pages/home'
      assert_select "a[href=?]", root_path, count: 2
      assert_select "a[href=?]", static_pages_help_path
      assert_select "a[href=?]", static_pages_about_path
      assert_select "a[href=?]", static_pages_contact_path
    end
  end
end
