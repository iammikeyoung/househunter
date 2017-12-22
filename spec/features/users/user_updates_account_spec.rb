require 'rails_helper'

feature "User Updates Account", %{
    As an authenticated user
    I want to update my information
    So that I can keep my profile info correct
  } do
  let(:user) { FactoryBot.create(:user) }

  scenario "authenticated user enters valid information" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end

    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"
    click_link 'Update'

    fill_in "First Name", with: "Archer"
    click_button "Save Changes"

    expect(page).to have_content("Profile updated")
    expect(page).to have_content("Archer")
  end

  scenario "authenticated user enters invalid information" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end

    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"
    click_link 'Update'

    fill_in "Last Name", with: ""
    fill_in "Email", with: "joe@email_mistake"
    click_button "Save Changes"

    expect(page).to have_content "Last name can't be blank"
    expect(page).to have_content "Email is invalid"
    expect(page).to_not have_content "Profile updated"
  end
end
