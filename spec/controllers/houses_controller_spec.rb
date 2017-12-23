require 'rails_helper'

RSpec.describe "Users", type: :request do
  subject(:house) { FactoryBot.create(:house) }
  subject(:authorized_user) { house.user }
  subject(:incorrect_user) { FactoryBot.create(:user) }

  describe "#show" do
    context "as an authorized user" do
      it "responds successfully" do
        post login_path, params: { session: { email: authorized_user.email, password: "pass2017" } }
        get house_path(house.id)

        expect(response).to be_success
        expect(response).to have_http_status "200"
      end
    end

    context "as an incorrect user" do
      it "redirects to user page" do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
        get house_path(house.id)

        expect(response).to have_http_status("302")
        expect(response).to redirect_to user_path(incorrect_user.id)
      end

      it "provides 'unauthorized' flash message" do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
        get house_path(house.id)

        expect(flash[:notice]).to match(/Unauthorized access/)
      end
    end

    context "as a guest" do
      it "redirects to the log in page" do
        get house_path(house.id)

        expect(response).to have_http_status("302")
        expect(response).to redirect_to login_path
      end

      it "provides 'log in' flash message" do
        get house_path(house.id)

        expect(flash[:notice]).to eq("Please log in.")
      end
    end
  end

  describe "#create" do
    context "as an authorized user" do
      it "adds a new house" do
        post login_path, params: { session: { email: authorized_user.email, password: "pass2017" } }
        new_house_params = FactoryBot.attributes_for(:house, name: "New Test House")

        expect {
          post houses_path, params: { house: new_house_params }
          expect(flash[:notice]).to match(/successfully added/)
          expect(response).to redirect_to users_path(authorized_user.id)
        }.to change(authorized_user.houses, :count).by(1)
      end
    end

    context "as an incorrect user" do
      it "does not add a new house" do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
        new_house_params = FactoryBot.attributes_for(:house, name: "New Test House")

        expect {
          post houses_path, params: { house: new_house_params }
        }.to_not change(authorized_user.houses, :count)
      end

      it "redirects to user page" do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
        new_house_params = FactoryBot.attributes_for(:house, name: "New Test House")
        post houses_path, params: { house: new_house_params }

        expect(response).to have_http_status("302")
        expect(response).to redirect_to user_path(incorrect_user.id)
      end

      it "provides 'unauthorized' flash message" do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
        new_house_params = FactoryBot.attributes_for(:house, name: "New Test House")
        post houses_path, params: { house: new_house_params }

        expect(flash[:notice]).to match(/Unauthorized access/)
      end
    end

    context "as a guest" do
      it "redirects to the log in page" do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
        new_house_params = FactoryBot.attributes_for(:house, name: "New Test House")
        post houses_path, params: { house: new_house_params }

        expect(response).to have_http_status("302")
        expect(response).to redirect_to login_path
      end

      it "provides 'log in' flash message" do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
        new_house_params = FactoryBot.attributes_for(:house, name: "New Test House")
        post houses_path, params: { house: new_house_params }

        expect(flash[:notice]).to eq("Please log in.")
      end
    end
  end

  describe "#update" do
    context "as an authorized user" do
      it "updates the house" do
        post login_path, params: { session: { email: authorized_user.email, password: "pass2017" } }
        house_params = FactoryBot.attributes_for(:house, name: "New House Name")
        patch house_path, params: { id: house.id, house: house_params }

        expect(house.reload.name).to eq "New Project Name"
        expect(flash[:notice]).to match(/successfully added/)
      end
    end

    context "as an incorrect user" do
      it "does not update the house" do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
        house_params = FactoryBot.attributes_for(:house, name: "New Name")
        patch house_path, params: { id: house.id, house: house_params }

        expect(house.reload.name).to_not eq "New Name"
      end

      it "redirects to user page" do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
        house_params = FactoryBot.attributes_for(:house, name: "New Name")
        patch house_path, params: { id: house.id, house: house_params }

        expect(response).to have_http_status("302")
        expect(response).to redirect_to user_path(incorrect_user.id)
      end

      it "provides 'unauthorized' flash message" do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
        house_params = FactoryBot.attributes_for(:house, name: "New Name")
        patch house_path, params: { id: house.id, house: house_params }

        expect(flash[:notice]).to match(/Unauthorized access/)
      end
    end

    context "as a guest" do
      it "does not update the house" do
        house_params = FactoryBot.attributes_for(:house, name: "New Name")
        patch house_path, params: { id: house.id, house: house_params }

        expect(house.reload.name).to_not eq "New Name"
      end

      it "redirects to log in page" do
        house_params = FactoryBot.attributes_for(:house, name: "New Name")
        patch house_path, params: { id: house.id, house: house_params }

        expect(response).to have_http_status("302")
        expect(response).to redirect_to login_path
      end

      it "provides 'log in' flash message" do
        house_params = FactoryBot.attributes_for(:house, name: "New Name")
        patch house_path, params: { id: house.id, house: house_params }

        expect(flash[:notice]).to match(/Please log in/)
      end
    end
  end

  describe "#destroy" do
    context "as an authorized user" do
      it "deletes the house" do
        post login_path, params: { session: { email: authorized_user.email, password: "pass2017" } }

        expect {
          delete :destroy, params: { id: house.id }
        }.to change(authorized_user.houses, :count).by(-1)
      end
    end

    context "as an incorrect user" do
      it "does not delete the house" do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }

        expect {
          delete :destroy, params: { id: house.id }
        }.to_not change(House, :count)
      end

      it "redirects to user page" do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
        delete :destroy, params: { id: house.id }

        expect(response).to have_http_status("302")
        expect(response).to redirect_to user_path(incorrect_user.id)
      end

      it "provides 'unauthorized' flash message" do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
        delete :destroy, params: { id: house.id }

        expect(flash[:notice]).to match(/Unauthorized access/)
      end
    end

    context "as a guest" do
      it "does not delete the house" do
        expect {
          delete :destroy, params: { id: house.id }
        }.to_not change(House, :count)
      end

      it "redirects to user page" do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
        delete :destroy, params: { id: house.id }

        expect(response).to have_http_status("302")
        expect(response).to redirect_to user_path(login_path)
      end

      it "provides 'unauthorized' flash message" do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
        delete :destroy, params: { id: house.id }

        expect(flash[:notice]).to match(/Please log in/)
      end
    end
  end
end
