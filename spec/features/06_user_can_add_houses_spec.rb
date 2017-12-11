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
      within('nav') { click_link 'Log In' }
      fill_in "Email",    with: "archer@example.gov"
      fill_in "Password", with: "sploosh1"
      click_button "Log In"
      click_link("Add A New House")

      expect(page).to have_content("New House Form")
      expect(page).to have_link("Cancel")
      fill_in "Zip Code", with: "02110A"
      click_button "Save"

      expect(page).to have_content("Street can't be blank")
      expect(page).to have_content("City can't be blank")
      expect(page).to have_content("State can't be blank")
      expect(page).to have_content("Zip code is the wrong length (should be 5 characters)")
    end

    scenario "user successfully adds a new house" do
      user = User.create!(email: "archer@example.gov",
                          password: "sploosh1",
                          password_confirmation: "sploosh1",
                          first_name: "Sterling",
                          last_name: "Archer")

      visit root_path
      within('nav') { click_link 'Log In' }
      fill_in "Email",    with: "archer@example.gov"
      fill_in "Password", with: "sploosh1"
      click_button "Log In"
      click_link "Add A New House"

      expect(page).to have_content("New House Form")
      expect(page).to have_link("Cancel")
      fill_in "Nickname", with: "Around Corner From Mom"
      fill_in "Street", with: "100 Street"
      fill_in "City", with: "City-Name"
      fill_in "State", with: "State-Name"
      fill_in "Zip Code", with: "01234"
      attach_file "house[house_profile_pic]", "#{Rails.root}/spec/support/images/house_photo.jpeg"
      click_button "Save"

      expect(page).to have_content("House successfully added")
      expect(page).to have_link("Around Corner From Mom")
      expect(page).to have_css("img[src*='house_photo.jpeg']")
    end

  end
