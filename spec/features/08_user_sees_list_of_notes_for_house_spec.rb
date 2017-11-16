require 'rails_helper'

feature "authorized user can see list of notes for a house in their portfolio" do

  scenario "user sees list of notes on house's show page that link to note's show page" do
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

    expect(page).to have_content("Living Room")
    expect(page).to have_content("Kitchen")
    expect(page).to have_link 'Back'
    expect(page).to have_link 'Add Room'
  end

  scenario "user does not see notes for another house in their portfolio" do
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

    house_two = House.create!(user: user,
                              name: "Above Italian Place",
                              street: "307 Hanover Street",
                              city: "Boston",
                              state: "MA",
                              zip_code: "02113")

    master_bedroom = Note.create!(house: house_two,
                              user: user,
                              room: "Master Bedroom",
                              rating: 1,
                              pros: "big walk-in closet!",
                              cons: "bathroom only has one sink!")
    dinning_room = Note.create!(house: house_two,
                              user: user,
                              room: "Dining Room",
                              rating: -1,
                              pros: "hardwood floors and opens to deck",
                              cons: "not enough space for larger table")

    visit root_path
    click_link 'Log In'
    fill_in "Email",    with: "archer@example.gov"
    fill_in "Password", with: "sploosh1"
    click_button "Log In"

    expect(page).to have_content("Near Work")
    expect(page).to have_content("Above Italian Place")
    click_link 'Near Work'

    expect(page).to have_content("Living Room")
    expect(page).to have_content("Kitchen")
    expect(page).to_not have_content("Master Bedroom")
    expect(page).to_not have_content("Dining Room")
  end

end
