require 'rails_helper'

RSpec.describe "Users", type: :request do
  subject(:house) { FactoryBot.create(:house) }
  subject(:authorized_user) { house.user }

  context "as an authorized user" do
    before(:each) { post login_path, params: { session: { email: user.email, password: "pass2017" } } }

    it "allows user to see house show page" do
      get house_path(house.id)

      expect(response).to be_success
      expect(response).to have_http_status "200"
    end

    it "allows a user to create a new house in their own account" do
      get house_path(house.id)

      expect(response).to be_success
      expect(response).to have_http_status "200"
    end

    it "allows a user to update an existing house in their own account" do
      get house_path(house.id)

      expect(response).to be_success
      expect(response).to have_http_status "200"
    end

    it "allows a user to destroy an existing house in their own account" do
      get house_path(house.id)

      expect(response).to be_success
      expect(response).to have_http_status "200"
    end
  end

  context "as an authenticated user" do
    let(:incorrect_user) { FactoryBot.create(:user) }

    before(:each) { post login_path, params: { session: { email: user.email, password: "pass2017" } } }

    it "does not show another user's house" do
      get house_path(house.id)

      expect(response).to have_http_status("302")
      expect(response).to redirect_to user_path(incorrect_user.id)
      expect(flash[:notice]).to match(/Unauthorized access/)
    end

    it "does not create a new house in another user's account" do
      get house_path(house.id)

      expect(response).to have_http_status("302")
      expect(response).to redirect_to user_path(incorrect_user.id)
      expect(flash[:notice]).to match(/Unauthorized access/)
    end

    it "does not update another user's house" do
      get house_path(house.id)

      expect(response).to have_http_status("302")
      expect(response).to redirect_to user_path(incorrect_user.id)
      expect(flash[:notice]).to match(/Unauthorized access/)
    end

    it "does not destroy another user's house" do
      get house_path(house.id)

      expect(response).to have_http_status("302")
      expect(response).to redirect_to user_path(incorrect_user.id)
      expect(flash[:notice]).to match(/Unauthorized access/)
    end
  end

  context "as a guest" do
    it "user is not allowed to access a house's show page and is redirected to log in" do
      get house_path(house.id)

      expect(response).to_not be_success
      expect(response).to have_http_status("302")
      expect(response).to redirect_to login_path
      expect(flash[:notice]).to eq("Please log in.")
    end

    it "user is not allowed to create a house and is redirected to log in" do
      get house_path(house.id)

      expect(response).to_not be_success
      expect(response).to have_http_status("302")
      expect(response).to redirect_to login_path
      expect(flash[:notice]).to eq("Please log in.")
    end

    it "user is not allowed to update a house and is redirected to log in" do
      get house_path(house.id)

      expect(response).to_not be_success
      expect(response).to have_http_status("302")
      expect(response).to redirect_to login_path
      expect(flash[:notice]).to eq("Please log in.")
    end

    it "user is not allowed to destroy a house and is redirected to log in" do
      get house_path(house.id)

      expect(response).to_not be_success
      expect(response).to have_http_status("302")
      expect(response).to redirect_to login_path
      expect(flash[:notice]).to eq("Please log in.")
    end
  end
end
