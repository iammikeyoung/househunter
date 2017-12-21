require 'rails_helper'

RSpec.describe "Users", type: :request do
  context "as an authorized user" do
    it "shows the user's page"
    it "deletes the users account"

    context "with valid attributes" do
      it "updates an existing user"
    end

    context "with invalid attributes" do
      it "does not update an existing user"
    end
  end

  context "as an authenticated user" do
    it "does not show another user's page"
    it "does not update another user"
    it "does not delete another user"
  end

  context "as a guest" do
    it "creates a new user account"
    it "does not show a user's page"
    it "does not update an existing user"
    it "does not delete an existing user"
  end
end

# RSpec.describe "Projects", type: :request do
#   context "as an authenticated user" do
#     before do
#       @user = FactoryGirl.create(:user)
#     end
#
#     context "with valid attributes" do
#       it "adds a project" do
#         project_params = FactoryGirl.attributes_for(:project)
#         sign_in @user
#         expect {
#           post projects_path, params: { project: project_params }
#         }.to change(@user.projects, :count).by(1)
#       end
#     end
#
#     context "with invalid attributes" do
#       it "does not add a project" do
#         project_params = FactoryGirl.attributes_for(:project, :invalid)
#         sign_in @user
#         expect {
#           post projects_path, params: { project: project_params }
#         }.to_not change(@user.projects, :count)
#       end
#     end
#   end
# end
