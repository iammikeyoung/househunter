require 'rails_helper'

feature "user can see list of notes for a house in their portfolio" do
  let!(:user) { FactoryBot.create(:user) }
  let!(:house) { FactoryBot.create(:house, user: user) }
  let!(:note1) { FactoryBot.create(:note, house: house, user: user) }
  let!(:note2) { FactoryBot.create(:note, house: house, user: user) }
  let!(:another_house) { FactoryBot.create(:house, user: user) }
  let!(:note_for_another_house)  { FactoryBot.create(:note, user: user, house: another_house) }

  scenario "user logs in and visits house show page to see house's notes" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end
    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"
    click_link(house.name)

    expect(page).to have_content(note1.room)
    expect(page).to have_content(note2.room)
    expect(page).to_not have_content(note_for_another_house)
  end
end
