require "rails_helper"

feature "User logs out", %{
    As an authenticated user
    I want to logout
    To be unauthenticated
  } do
  let(:user) { FactoryBot.create(:user) }

  scenario "user enters valid log in data and then logs out" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end

    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"

    click_link 'Log Out'

    expect(page).to have_content("You have successfully logged out")
    expect(page).to have_link("Log In")
    expect(page).to_not have_link("Log Out")
  end

end
