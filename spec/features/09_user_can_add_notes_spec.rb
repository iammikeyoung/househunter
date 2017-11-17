require 'rails_helper'

feature "authorized user can add a new note to a house in their portfolio" do

  scenario "user provides valid information for new note" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    house_one = House.create!(user: user,
                              name: "Near Work",
                              street: "101 Arch Street",
                              city: "Boston",
                              state: "MA",
                              zip_code: "02110")

    living_room = Note.create!(house: house_one,
                              user: user,
                              room: "Living Room",
                              rating: 1,
                              pros: "open floor-plan layout and great for entertaining",
                              cons: "no fireplace")

    visit root_path
    click_link 'Log In'
    fill_in "Email",    with: "archer@example.gov"
    fill_in "Password", with: "sploosh1"
    click_button "Log In"
    click_link 'Near Work'
    click_link 'Add Room'

    expect(page).to have_current_path("/houses/#{house_one.id}/notes/new")
    expect(page).to have_content("New Room Form")
    expect(page).to have_link 'Cancel'

    fill_in "Room",   with: "Kitchen"
    select "Dislike", from: "Rating"
    fill_in "Pros",   with: "lots of cabinet space and good flow into sun room"
    fill_in "Cons",   with: "gallery style - too small"
    click_button "Save"

    expect(page).to have_content("Note successfully added!")
    expect(page).to have_content("Kitchen")
  end

  scenario "user provides invalid information for new note" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    house_one = House.create!(user: user,
                              name: "Near Work",
                              street: "101 Arch Street",
                              city: "Boston",
                              state: "MA",
                              zip_code: "02110")

    living_room = Note.create!(house: house_one,
                              user: user,
                              room: "Living Room",
                              rating: 1,
                              pros: "open floor-plan layout and great for entertaining",
                              cons: "no fireplace")

    visit root_path
    click_link 'Log In'
    fill_in "Email",    with: "archer@example.gov"
    fill_in "Password", with: "sploosh1"
    click_button "Log In"
    click_link 'Near Work'
    click_link 'Add Room'
    click_button "Save"

    expect(page).to have_content("New Room Form")
    expect(page).to have_content("Room can't be blank")
  end

end
