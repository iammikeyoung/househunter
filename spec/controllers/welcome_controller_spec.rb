require 'rails_helper'

RSpec.describe WelcomeController, type: :request do
  describe "Home Page" do
    it "responds successfully" do
      get root_path
      expect(response).to be_success
      expect(response).to have_http_status "200"
    end
  end

  describe "#index" do
    it "responds successfully" do
      get welcome_index_path
      expect(response).to be_success
      expect(response).to have_http_status "200"
    end
  end
end
