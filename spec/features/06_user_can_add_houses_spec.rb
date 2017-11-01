require 'rails_helper'

feature "Authorized User Adds Houses",
  %{
    As an authorized user
    I want to be able to add a new house to my portfolio
    So that I can see it as part of my list of houses

    Acceptance Criteria:
    [ ] user must be authenticated
    [ ] house must have street, city, state & zip code
    [ ] user must receive error messages if invalid info is entered
  } do

    scenario "user does not provide valid info for a house" do
      user = User.create!(email: "archer@example.gov",
                          password: "sploosh1",
                          password_confirmation: "sploosh1",
                          first_name: "Sterling",
                          last_name: "Archer")

      visit root_path
      click_link 'Log In'
      fill_in "Email",    with: "archer@example.gov"
      fill_in "Password", with: "sploosh1"
      click_button "Log In"
      click_link("Add House")

      expect(page).to have_content("New House Form")
      expect(page).to have_link("Cancel")
      fill_in "Zip Code", with: "02110A"
      click_button "Add House"

      expect(page).to have_content("Street Error Msg")
      expect(page).to have_content("City Error Msg")
      expect(page).to have_content("State Error Msg")
      expect(page).to have_content("Zip Code Error Msg")
    end

    scenario "user successfully adds a new house" do
      visit root_path
      click_link 'Log In'
      fill_in "Email",    with: "archer@example.gov"
      fill_in "Password", with: "sploosh1"
      click_button "Log In"
      click_link("Add New House")

      expect(page).to have_current_path("/")
      expect(page).to have_link("Cancel")
      fill_in "Name", with: "Around Corner From Mom"
      fill_in "Name", with: "100 Street"
      fill_in "Name", with: "City-Name"
      fill_in "Name", with: "State-Name"
      fill_in "Name", with: "01234"
      click_button "Add House"

      expect(page).to have_content("House successfully added")
      expect(page).to have_link("Around Corner From Mom")
    end

  end
