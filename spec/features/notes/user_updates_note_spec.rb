require 'rails_helper'

feature "authorized user updates a note" do
  let!(:user) { FactoryBot.create(:user) }
  let!(:house) { FactoryBot.create(:house, user: user) }
  let!(:note) { FactoryBot.create(:note, house: house, user: user, room: "Same Old Room") }

  scenario "user updates note with valid info" do
    new_room = "Living Room"
    new_rating = "Like"
    new_pros = "hardwood floors!"
    new_cons = "no carpet though..."

    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end
    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"
    click_link(house.name)
    click_link(note.room)
    click_link 'Edit Note'

    expect(page).to have_content("Edit Note")
    expect(page).to have_link "Cancel"

    fill_in "Room",       with: new_room
    select new_rating,    from: "Rating"
    fill_in "Pros",       with: new_pros
    fill_in "Cons",       with: new_cons
    click_button "Update"

    expect(page).to have_content("Note successfully updated")

    expect(page).to have_content(new_room)
    expect(page).to have_content("Rating: 1")
    expect(page).to have_content(new_cons)
    expect(page).to have_content(new_pros)

    expect(page).to_not have_content("Same Old Room")
    expect(page).to_not have_content("Rating: 0")
    expect(page).to_not have_content("Things you like")
    expect(page).to_not have_content("Things you do not like")
  end

  scenario "user updates note with invalid info" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end
    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"
    click_link(house.name)
    click_link(note.room)
    click_link 'Edit Note'

    fill_in "Room", with: ""
    click_button 'Update'

    expect(page).to have_content("Room can't be blank")
  end
end
