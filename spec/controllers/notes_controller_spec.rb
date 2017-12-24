require 'rails_helper'

RSpec.describe "Users", type: :request do
  subject(:user) { FactoryBot.create(:user) }
  subject(:house) { FactoryBot.create(:house, user: user) }
  let!(:note) { FactoryBot.create(:note, house: house, user: user) }
  subject(:incorrect_user) { FactoryBot.create(:user) }

  describe "#show" do
    context "as an authorized user" do
      it "responds successfully" do
        post login_path, params: { session: { email: user.email, password: "pass2017" } }
        get note_path(note.id)
        aggregate_failures do
          expect(response).to be_success
          expect(response).to have_http_status "200"
        end
      end
    end

    context "as an incorrect user" do
      before(:each) do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
      end

      it "redirects to user page" do
        get note_path(note.id)
        aggregate_failures do
          expect(response).to have_http_status("302")
          expect(response).to redirect_to user_path(incorrect_user.id)
        end
      end

      it "provides an 'unauthorized' flash message" do
        get note_path(note.id)

        expect(flash[:notice]).to match(/Unauthorized access/)
      end
    end

    context "as a guest" do
      it "redirects to the log in page" do
        get note_path(note.id)
        aggregate_failures do
          expect(response).to have_http_status("302")
          expect(response).to redirect_to login_path
        end
      end

      it "provides 'log in' flash message" do
        get house_path(house.id)

        expect(flash[:notice]).to eq("Please log in.")
      end
    end
  end

  describe "#create" do
    context "as an authorized user" do
      it "adds a new note" do
        new_note_params = FactoryBot.attributes_for(:note, house: house, user: user)
        post login_path, params: { session: { email: user.email, password: "pass2017" } }

        expect {
          post house_notes_path(house.id), params: { note: new_note_params }
          expect(flash[:notice]).to match(/successfully added/)
          expect(response).to redirect_to house_path(house.id)
        }.to change(house.notes, :count).by(1)
      end
    end

    context "as an incorrect user" do
      let(:new_note_params) { FactoryBot.attributes_for(:note, house: house, user: user) }

      before(:each) do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
      end

      it "does not add a new note" do
        expect {
          post house_notes_path(house.id), params: { note: new_note_params }
        }.to change(user.notes, :count).by(0)
      end

      it "redirects to user page" do
        post house_notes_path(house.id), params: { note: new_note_params }

        expect(response).to have_http_status "302"
        expect(response).to redirect_to user_path(incorrect_user.id)
      end

      it "provides an 'unauthorized' flash message" do
        post house_notes_path(house.id), params: { note: new_note_params }

        expect(flash[:notice]).to match(/Unauthorized access/)
      end
    end

    context "as a guest" do
      let(:new_note_params) { FactoryBot.attributes_for(:note, house: house, user: user) }

      it "does not add a new note" do
        expect {
          post house_notes_path(house.id), params: { note: new_note_params }
        }.to change(user.notes, :count).by(0)
      end

      it "redirects to the log in page" do
        post house_notes_path(house.id), params: { note: new_note_params }

        expect(response).to have_http_status("302")
        expect(response).to redirect_to login_path
      end

      it "provides 'log in' flash message" do
        post house_notes_path(house.id), params: { note: new_note_params }

        expect(flash[:notice]).to eq("Please log in.")
      end
    end
  end

  describe "#update" do
    let(:note_updates) { FactoryBot.attributes_for(:note, room: "New Room Name") }

    context "as an authorized user" do
      it "updates the note" do
        post login_path, params: { session: { email: user.email, password: "pass2017" } }
        patch note_path(note.id), params: { note: note_updates }

        expect(note.reload.room).to eq("New Room Name")
        expect(flash[:notice]).to match(/successfully updated/)
      end
    end

    context "as an incorrect user" do
      before(:each) do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
      end

      it "does not update the note" do
        patch note_path(note.id), params: { note: note_updates }

        expect(note.reload.room).to_not eq("New Room Name")
        expect(note.reload.room).to eq(note.room)
      end

      it "redirects to user page" do
        patch note_path(note.id), params: { note: note_updates }

        expect(response).to have_http_status("302")
        expect(response).to redirect_to user_path(incorrect_user.id)
      end

      it "provides 'unauthorized' flash message" do
        patch note_path(note.id), params: { note: note_updates }

        expect(flash[:notice]).to match(/Unauthorized access/)
      end
    end

    context "as a guest" do
      it "does not update the house" do
        patch note_path(note.id), params: { note: note_updates }

        expect(note.reload.room).to_not eq("New Room Name")
        expect(note.reload.room).to eq(note.room)
      end

      it "redirects to log in page" do
        patch note_path(note.id), params: { note: note_updates }

        expect(response).to have_http_status("302")
        expect(response).to redirect_to login_path
      end

      it "provides 'log in' flash message" do
        patch note_path(note.id), params: { note: note_updates }

        expect(flash[:notice]).to match(/Please log in/)
      end
    end
  end

  describe "#destroy" do
    context "as an authorized user" do
      it "deletes the note" do
        post login_path, params: { session: { email: user.email, password: "pass2017" } }

        expect {
          delete note_path(note.id)
          expect(flash[:notice]).to match(/successfully deleted/)
          expect(response).to redirect_to house_path(house.id)
        }.to change(house.notes, :count).by(-1)
      end
    end

    context "as in incorrect user" do
      before(:each) do
        post login_path, params: { session: { email: incorrect_user.email, password: "pass2017" } }
      end

      it "does not delete the note" do
        expect {
          delete note_path(note.id)
        }.to change(house.notes, :count).by(0)
      end

      it "redirects to user page" do
        delete note_path(note.id)

        expect(response).to have_http_status("302")
        expect(response).to redirect_to user_path(incorrect_user.id)
      end

      it "provides 'unauthorized' flash message" do
        delete note_path(note.id)

        expect(flash[:notice]).to match(/Unauthorized access/)
      end
    end

    context "as a guest" do
      it "does not delete the note" do
        expect {
          delete note_path(note.id)
        }.to change(house.notes, :count).by(0)
      end

      it "redirects to log in page" do
        delete note_path(note.id)

        expect(response).to have_http_status("302")
        expect(response).to redirect_to login_path
      end

      it "provides 'log in' flash message" do
        delete note_path(note.id)

        expect(flash[:notice]).to match(/Please log in/)
      end
    end
  end
end
