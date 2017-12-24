require 'rails_helper'

feature "user note details on note show page" do
  let!(:user) { FactoryBot.create(:user) }
  let!(:house) { FactoryBot.create(:house, user: user) }
  let!(:note1) { FactoryBot.create(:note, house: house, user: user) }
  let!(:note2) { FactoryBot.create(:note, house: house, user: user) }
  let!(:note3) { FactoryBot.create(:note, house: house, user: user) }
  let!(:incorrect_user) { FactoryBot.create(:user) }

  scenario "user logs in and visits show page to see note details" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end
    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"
    click_link(house.name)
    click_link(note1.room)

    expect(page).to have_link 'Back'
    expect(page).to have_link 'Edit Note'
    expect(page).to have_link 'Delete Note'

    expect(page).to have_content(note1.room)
    expect(page).to have_content(note1.rating)
    expect(page).to have_content(note1.pros)
    expect(page).to have_content(note1.cons)
  end

  scenario "user logs in and tries to see note details for note that does not belong to them" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end
    fill_in "Email",    with: "#{incorrect_user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"
    visit note_path(note1)

    expect(page).to_not have_content(note1.room)
    expect(page).to have_content("Unauthorized access")
  end

  scenario "guest tries to see note details" do
    visit note_path(note1)

    expect(page).to_not have_content(note1.room)
    expect(page).to have_content("Please log in")
  end
end
