require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  before(:each) do
    @user = FactoryBot.create(:user, password: "pass2017")
  end

  context "user not logged in" do
    it "logs in user with correct credentials" do
      post login_path, params: {
        session: {
          email: @user.email,
          password: "pass2017"
        }
      }

      expect(session[:user_id]).to eq(@user.id)
      expect(flash[:notice]).to eq("You have successfully logged in")
      # expect(response).to have_http_status "302"
      # expect(response).to redirect_to user_path(@user)
    end

    it "does not login user with incorrect password" do
      post login_path, params: {
        session: {
          email: @user.email,
          password: "incorrect"
        }
      }

      expect(session[:user_id]).to_not eq(@user.id)
      expect(session[:user_id]).to be_nil
      expect(flash[:notice]).to eq("Invalid email/password combination")
    end

    it "does not login user with an unregistered email" do
      post login_path, params: {
        session: {
          email: "not_registered@example.com",
          password: "notregistered"
        }
      }

      expect(session[:user_id]).to_not eq(@user.id)
      expect(session[:user_id]).to be_nil
      expect(flash[:notice]).to eq("That email is not registered")
    end
  end

  context "user logged in" do
    it "should logout user" do
      post login_path, params: { session: { email: @user.email, password: "pass2017" } }
      delete logout_path

      expect(session[:user_id]).to_not eq(@user.id)
      expect(session[:user_id]).to be_nil
      expect(flash[:notice]).to eq("You have successfully logged out")
    end
  end
end
