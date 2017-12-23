require 'rails_helper'

feature "authorized user edits a house" do
  let!(:user) { FactoryBot.create(:user) }
  let!(:house) { FactoryBot.create(:house, user: user) }

  scenario "user successfully updates a house" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end
    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"
    click_link house.name
    click_link 'Edit'

    expect(page).to have_content("Edit House Form")
    fill_in "Nickname", with: "New House Name"
    fill_in "Street",   with: "13707 Steeple Chase Terrace"
    click_button "Update"

    expect(page).to have_content("House successfully updated")
    expect(page).to have_link("New House Name")
    expect(page).to_not have_content(house.name)

    click_link "New House Name"
    expect(page).to have_content("13707 Steeple Chase Terrace")
    expect(page).to_not have_content(house.street)
  end

  scenario "user updates house with invalid data" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end
    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"
    click_link house.name
    click_link 'Edit'
    fill_in "Nickname", with: "New house name is way too long!!"
    fill_in "Street",   with: "13707 Steeple Chase Terrace"
    click_button "Update"

    expect(page).to have_content("prohibited this question from being saved")
    expect(page).to have_content("Edit House Form")

    click_link 'Cancel'

    expect(page).to have_content(house.name)
    expect(page).to_not have_content("New house name is way too long!!")

    click_link house.name

    expect(page).to have_content(house.street)
    expect(page).to_not have_content("13707 Steeple Chase Terrace")
  end
end
