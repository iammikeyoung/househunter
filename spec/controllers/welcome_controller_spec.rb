require 'rails_helper'

RSpec.describe WelcomeController do

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("welcome/index")
    end

    it "returns a 200 OK status" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

end
