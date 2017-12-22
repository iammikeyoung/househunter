require 'rails_helper'

feature "User Sign Up", %{
  As a prospective user
  I want to create an account
  To be a registered & authenticated user

  Acceptance Criteria:
  [ ] A valid email address must be submitted
  [ ] A valid password must be submitted x2
  [ ] The two password submissions must match each other

  [ ] If requirements are not met,
      [ ] user is not saved to the database (not registered or authenticated)
      [ ] user is given error message
  [ ] If requirements are met,
      [ ] Prospective user's info is saved to the database (registered)
      [ ] User is logged in (authenticated)
      [ ] User is directed to user page
} do

  scenario "prospective user enters valid data to create an account" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Sign Up'
    end

    fill_in 'First Name', with: 'Arya'
    fill_in 'Last Name', with: 'Stark'
    fill_in 'Email', with: 'arya@winterfell.com'
    fill_in 'Password', with: 'HouseStark4Ever'
    fill_in 'Confirmation', with: 'HouseStark4Ever'
    click_button 'Create my account'

    expect(page).to have_content("You have signed up successfully.")
    expect(page).to have_content("Welcome Arya!")
  end

  scenario "prospective user enters invalid data to create an account" do
    visit root_path
    within(".nav-desktop") do
      click_on "Sign Up"
    end

    fill_in "First Name",     with: "Sterling"
    fill_in "Last Name",      with: ""
    fill_in "Email",          with: "archer@example-gov"
    fill_in "Password",       with: "supersecret"
    fill_in "Confirmation",   with: "different"
    click_on "Create my account"

    expect(page).to have_content "errors prohibited this user from being saved"
    expect(page).to have_content "Last name can't be blank"
    expect(page).to have_content "Email is invalid"
    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  scenario "prospective user enters email that is already registered" do
    existing_user = FactoryBot.create(:user)

    visit root_path
    within(".nav-desktop") do
      click_on "Sign Up"
    end

    fill_in "First Name", with: existing_user.first_name
    fill_in "Last Name", with: existing_user.last_name
    fill_in "Email", with: existing_user.email
    fill_in "Password", with: existing_user.password
    fill_in "Confirmation", with: existing_user.password
    click_on "Create my account"

    expect(page).to have_content "Email has already been taken"
  end
end
