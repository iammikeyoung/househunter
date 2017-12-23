require 'rails_helper'

feature "Authorized User Adds Houses",
  %{
    As an authorized user
    I want to be able to add a new house to my portfolio
    So that I can see it as part of my list of houses
  } do

  let!(:user) { FactoryBot.create(:user) }
  let(:house) { FactoryBot.build(:house) }

  scenario "user successfully adds a new house" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end
    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"

    expect(page).to_not have_content(house.name)

    click_link "Add A New House"

    expect(page).to have_content("New House Form")
    expect(page).to have_link("Cancel")

    fill_in "Nickname", with: house.name
    fill_in "Street", with: house.street
    fill_in "City", with: house.city
    fill_in "State", with: house.state
    fill_in "Zip Code", with: house.zip_code
    attach_file "house[house_profile_pic]", "#{Rails.root}/spec/support/images/house_photo.jpeg"
    click_button "Save"

    expect(page).to have_content("House successfully added")
    expect(page).to have_link(house.name)
    expect(page).to have_css("img[src*='house_photo.jpeg']")
  end

  scenario "user adds new house with invalid data" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end
    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"
    click_link("Add A New House")

    fill_in "Zip Code", with: "02110A"
    click_button "Save"

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Street can't be blank")
    expect(page).to have_content("City can't be blank")
    expect(page).to have_content("State can't be blank")
    expect(page).to have_content("State is the wrong length")
    expect(page).to have_content("State is invalid")
    expect(page).to have_content("Zip code is the wrong length (should be 5 characters)")
  end
end
