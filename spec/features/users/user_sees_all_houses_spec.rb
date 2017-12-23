require 'rails_helper'

feature "user sees a list of their houses" do
  let!(:user) { FactoryBot.create(:user) }
  let!(:another_user) { FactoryBot.create(:user) }
  let!(:user_house1) { FactoryBot.create(:house, user: user) }
  let!(:user_house2) { FactoryBot.create(:house, user: user) }
  let!(:another_user_house) { FactoryBot.create(:house, user: another_user) }

  scenario "user signs in and sees a list of their houses" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end
    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"

    expect(page).to have_content(user_house1.name)
    expect(page).to have_content(user_house2.name)
    expect(page).to_not have_content(another_user_house.name)
  end

  scenario "unauthenticated user tries to see a list of their houses" do
    visit user_path(user)

    expect(page).to have_content("Please log in.")
  end
end
