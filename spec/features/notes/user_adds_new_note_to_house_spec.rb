require 'rails_helper'

feature "authorized user can add a new note to a house in their portfolio" do
  let!(:user) { FactoryBot.create(:user) }
  let!(:house) { FactoryBot.create(:house, user: user) }
  let!(:note1) { FactoryBot.create(:note, house: house, user: user) }
  let(:new_note) { FactoryBot.build(:note) }

  scenario "user provides valid information for new note" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end
    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"
    click_link(house.name)

    expect(page).to_not have_content(new_note.room)

    click_link "Add Room"

    expect(page).to have_content("New Note Form")
    expect(page).to have_link("Cancel")

    fill_in "Room",       with: new_note.room
    select "Dislike",     from: "Rating"
    fill_in "Pros",       with: new_note.pros
    fill_in "Cons",       with: new_note.cons
    click_button "Save"

    expect(page).to have_content("Note successfully added!")
    expect(page).to have_link(new_note.room)
    expect(page).to have_link(note1.room)
  end

  scenario "user provides invalid information for new note" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end
    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"
    click_link(house.name)
    click_link "Add Room"
    click_button "Save"

    expect(page).to have_content("Room can't be blank")
  end
end
