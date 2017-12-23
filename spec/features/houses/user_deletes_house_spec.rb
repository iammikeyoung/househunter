require 'rails_helper'

feature "authorized deletes a house" do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user_house1) { FactoryBot.create(:house, user: user) }
  let!(:user_house2) { FactoryBot.create(:house, user: user) }

  scenario "user successfully deletes a house from their list" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end
    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"

    expect(page).to have_content(user_house1.name)
    expect(page).to have_content(user_house2.name)

    click_link user_house1.name
    within("#house-details-buttons") do
      click_link 'Delete'
    end

    expect(page).to have_content("House deleted")
    expect(page).to have_content(user_house2.name)
    expect(page).to_not have_content(user_house1.name)
  end
end
