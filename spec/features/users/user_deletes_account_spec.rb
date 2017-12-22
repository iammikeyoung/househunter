require 'rails_helper'

feature "User Deletes Account", %{
  As an authenticated user
  I want to delete my account
  So that my information is no longer retained by the app
} do
  let(:user) { FactoryBot.create(:user) }

  scenario "authenticated user successfully deletes account" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end

    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"

    click_link 'Delete'

    expect(page).to have_content("User deleted")
    expect(page).to_not have_link("Delete")
  end
end
