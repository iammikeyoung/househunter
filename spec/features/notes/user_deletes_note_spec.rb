require 'rails_helper'

feature "authorized user can delete a note" do
  let!(:user) { FactoryBot.create(:user) }
  let!(:house) { FactoryBot.create(:house, user: user) }
  let!(:note1) { FactoryBot.create(:note, house: house, user: user) }
  let!(:note2) { FactoryBot.create(:note, house: house, user: user) }
  let!(:note3) { FactoryBot.create(:note, house: house, user: user) }

  scenario "user logs in and deletes a note" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end
    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"
    click_link(house.name)
    click_link(note1.room)

    click_link 'Delete Note'

    expect(page).to have_content("Note successfully deleted")
    expect(page).to have_content("House Details")
    expect(page).to have_content("All Notes")
    expect(page).to_not have_content(note1.room)

    expect(page).to have_content(note2.room)
    expect(page).to have_content(note3.room)
  end
end
