require 'rails_helper'

feature "user sees details or a specific house" do
  let!(:user) { FactoryBot.create(:user) }
  let!(:another_user) { FactoryBot.create(:user) }
  let!(:user_house1) { FactoryBot.create(:house, user: user, ) }
  let!(:user_house2) { FactoryBot.create(:house, user: user) }
  let!(:another_user_house) { FactoryBot.create(:house, user: another_user) }

  scenario "user logs in and navigates to house show page" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end
    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"
    click_link "#{user_house1.name}"

    expect(page).to have_link 'Back'
    expect(page).to have_link 'Add Room'
    expect(page).to have_content(user_house1.name)
    expect(page).to have_content(user_house1.asking_amount)
    expect(page).to have_content(user_house1.total_sqft)
    expect(page).to_not have_content(user_house2.name)

    click_link "Back"
    expect(page).to have_content(user_house1.name)
    expect(page).to have_content(user_house2.name)
  end

  scenario "user logs in and attempts to see another user's house details" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end
    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"
    visit house_path(another_user_house)

    expect(page).to have_content("Unauthorized access")
  end

  scenario "guest tries to see house details" do
    visit house_path(another_user_house)

    expect(page).to have_content("Please log in")
  end
end
