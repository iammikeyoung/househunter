require 'rails_helper'

RSpec.describe "Users", type: :request do
  subject(:user) { FactoryBot.create(:user) }

  context "as an authorized user" do
    before(:each) { post login_path, params: { session: { email: user.email, password: "pass2017" } } }

    it "shows the user's page" do
      get user_path(user.id)

      expect(response).to be_success
      expect(response).to have_http_status "200"
    end

    it "destroys the users account" do
      delete user_path(user.id)

      expect(session[:user_id]).to be_nil
      expect(flash[:notice]).to match(/User deleted/)
      expect(response).to redirect_to "/"
    end

    it "updates an existing user" do
      updated_user_params = FactoryBot.attributes_for(:user, password: "pass2018")
      patch user_path(user.id), params: { user: updated_user_params}

      # expect(user.password).to eq("pass2018")
      expect(response).to redirect_to user_path(user.id)
      expect(flash[:notice]).to match(/updated/)
    end
  end

  context "as an authenticated user" do
    let(:another_user) { FactoryBot.create(:user) }
    before(:each) { post login_path, params: { session: { email: another_user.email, password: "pass2017" } } }

    it "does not show another user's page" do
      get user_path(user.id)

      expect(response).to_not be_success
      expect(response).to have_http_status("302")
      expect(response).to redirect_to user_path(another_user.id)
      expect(flash[:notice]).to match(/Unauthorized access/)
    end

    it "does not update another user" do
      updated_user_params = FactoryBot.attributes_for(:user, password: "pass2018")
      patch user_path(user.id)

      expect(response).to_not be_success
      expect(response).to have_http_status("302")
      expect(response).to redirect_to user_path(another_user.id)
      expect(flash[:notice]).to match(/Unauthorized access/)
    end

    it "does not destroy another user" do
      delete user_path(user.id)

      expect(response).to_not be_success
      expect(response).to have_http_status("302")
      expect(response).to redirect_to user_path(another_user.id)
      expect(flash[:notice]).to match(/Unauthorized access/)
    end
  end

  context "as a guest" do
    it "creates a new user account with valid params" do
      new_user_params = FactoryBot.attributes_for(:user)
      post users_path, params: { user: new_user_params }

      expect(controller).to set_flash[:notice]
      expect(flash[:notice]).to match(/signed up successfully/)
      expect(session[:user_id]).to_not be_nil
    end

    it "does not show a user's page and redirects to log in" do
      get user_path(user.id)

      expect(response).to_not be_success
      expect(response).to have_http_status("302")
      expect(response).to redirect_to login_path
      expect(flash[:notice]).to eq("Please log in.")
    end

    it "does not update an existing user and redirects to log in" do
      patch user_path(user.id)

      expect(response).to_not be_success
      expect(response).to have_http_status("302")
      expect(response).to redirect_to login_path
      expect(flash[:notice]).to eq("Please log in.")
    end

    it "does not delete an existing user and redirects to log in" do
      patch user_path(user.id)

      expect(response).to_not be_success
      expect(response).to have_http_status("302")
      expect(response).to redirect_to login_path
      expect(flash[:notice]).to eq("Please log in.")
    end
  end
end
