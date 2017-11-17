require 'rails_helper'

feature "authorized user can see the show page for an associated note to a house in their portfolio" do

  scenario "user can access note's show page" do
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
    click_link 'Living Room'

    expect(page).to have_content("Notes For Living Room")
    expect(page).to have_content("Rating: 1")
    expect(page).to have_content("open floor-plan")
    expect(page).to have_content("no fireplace")
    expect(page).to have_link 'Back'
  end

  scenario "user updates note with valid info" do
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
    click_link 'Living Room'

    click_link 'Edit'

    expect(page).to have_content("Edit Living Room")
    expect(page).to have_link "Cancel"
    select "Neutral", from: "Rating"
    fill_in "Cons", with: "Can't fit our couch!!"
    click_button "Save"

    expect(page).to have_content("Note successfully updated")
    expect(page).to have_content("Rating: 0")
    expect(page).to have_content("Cons: Can't fit our couch!!")
  end

  scenario "user updates note with invalid info" do
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
    click_link 'Living Room'
    click_link 'Edit'
    fill_in "Room", with: ""
    click_button 'Save'

    expect(page).to have_content("Room can't be blank")
  end

  scenario "user deletes note" do
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
    kitchen = Note.create!(house: house_one,
                              user: user,
                              room: "Kitchen",
                              rating: -1,
                              pros: "lots of cabinet space and good flow into sun room",
                              cons: "gallery style - too small")

    visit root_path
    click_link 'Log In'
    fill_in "Email",    with: "archer@example.gov"
    fill_in "Password", with: "sploosh1"
    click_button "Log In"
    click_link 'Near Work'
    click_link 'Kitchen'

    expect(page).to have_link 'Back'
    click_link 'Delete'

    expect(page).to have_content("Note successfully deleted")
    expect(page).to have_content("House Show Page")
    expect(page).to have_content("Living Room")
    expect(page).to_not have_content("Kitchen")
  end

end
