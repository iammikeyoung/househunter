require 'rails_helper'

feature "User Updates Account", %{
  As an authenticated user
  I want to update my information
  So that I can keep my profile info correct

  Acceptance Criteria:
  [ ] Update first Name & last Name
  [ ] Update email with valid email address
  [ ] Update password with valid password

} do

  scenario "authenticated user enters invalid information" do
    user = User.create!(email: "duchess@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    visit root_path
    click_link 'Log In'
    fill_in "Email",    with: "duchess@example.gov"
    fill_in "Password", with: "sploosh1"
    click_button "Log In"
    expect(page).to have_link("Update")
    click_link 'Update'


    fill_in "Email", with: ""
    click_button "Update Account"

    expect(page).to have_current_path("/users/#{user.id}")
    expect(page).to have_content "Email is invalid"
  end

  scenario "authenticated user enters valid information" do
    user = User.create!(email: "duchess@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    visit root_path
    click_link 'Log In'
    fill_in "Email",    with: "duchess@example.gov"
    fill_in "Password", with: "sploosh1"
    click_button "Log In"
    expect(page).to have_link("Update")
    click_link 'Update'


    fill_in "First Name", with: "Mr."
    click_button "Update Account"

    expect(page).to have_current_path("/users/#{user.id}")
    expect(page).to have_content("Profile updated")
    expect(page).to have_content("Mr.")
  end

end

feature "User Deletes Account", %{
  As an authenticated user
  I want to delete my account
  So that my information is no longer retained by the app

  Acceptance Criteria:
  [ ] User can no longer login with email address & password
  [ ] User deleted from Users table
  [ ] User notes are deleted from Notes table
  [ ] If user is only person associated with Portfolio
    [ ] Delete portfolio & houses in portfolio

} do

  scenario "authenticated user successfully deletes account" do
    user = User.create!(email: "duchess@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    visit root_path
    click_link 'Log In'
    fill_in "Email",    with: "duchess@example.gov"
    fill_in "Password", with: "sploosh1"
    click_button "Log In"
    expect(page).to have_link("Delete")
    click_link 'Delete'

    expect(page).to have_current_path("/")
    expect(page).to have_content("User deleted")
  end

end
