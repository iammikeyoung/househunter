require 'rails_helper'

feature "User must be signed in to assess notes" do

  scenario "unauthenticated user tries to access note show page" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    house = House.create!(user: user,
                              name: "Near Work",
                              street: "101 Arch Street",
                              city: "Boston",
                              state: "MA",
                              zip_code: "02110")
    kitchen = Note.create!(house: house,
                              user: user,
                              room: "Kitchen",
                              rating: -1,
                              pros: "lots of cabinet space and good flow into sun room",
                              cons: "gallery style - too small")

    # shallow path
    visit note_path(kitchen)
    expect(page).to have_content("Please log in.")
    expect(page).to have_current_path(login_path)

    # nested path
    visit house_note_path(house_id: house.id, id: kitchen.id)
    expect(page).to have_content("Please log in.")
    expect(page).to have_current_path(login_path)
  end

  scenario "unauthenticated user tries to access note edit page" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    house = House.create!(user: user,
                              name: "Near Work",
                              street: "101 Arch Street",
                              city: "Boston",
                              state: "MA",
                              zip_code: "02110")

    kitchen = Note.create!(house: house,
                              user: user,
                              room: "Kitchen",
                              rating: -1,
                              pros: "lots of cabinet space and good flow into sun room",
                              cons: "gallery style - too small")

    # shallow path
    visit edit_note_path(kitchen)
    expect(page).to have_content("Please log in.")
    expect(page).to have_current_path(login_path)

    # nested path
    visit edit_house_note_path(house, kitchen)
    expect(page).to have_content("Please log in.")
    expect(page).to have_current_path(login_path)
  end

  scenario "unauthenticated user tries to access note update page" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    house = House.create!(user: user,
                              name: "Near Work",
                              street: "101 Arch Street",
                              city: "Boston",
                              state: "MA",
                              zip_code: "02110")

    kitchen = Note.create!(house: house,
                              user: user,
                              room: "Kitchen",
                              rating: -1,
                              pros: "lots of cabinet space and good flow into sun room",
                              cons: "gallery style - too small")

    # shallow path
    page.driver.submit :patch, note_path(kitchen), {}
    expect(page).to have_content("Please log in.")
    expect(page).to have_current_path(login_path)

    # nested path
    page.driver.submit :patch, house_note_path(house, kitchen), {}
    expect(page).to have_content("Please log in.")
    expect(page).to have_current_path(login_path)
  end

  scenario "unauthenticated user tries to access note destroy page" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    house = House.create!(user: user,
                              name: "Near Work",
                              street: "101 Arch Street",
                              city: "Boston",
                              state: "MA",
                              zip_code: "02110")

    kitchen = Note.create!(house: house,
                              user: user,
                              room: "Kitchen",
                              rating: -1,
                              pros: "lots of cabinet space and good flow into sun room",
                              cons: "gallery style - too small")

    # shallow path
    page.driver.submit :delete, note_path(kitchen), {}
    expect(page).to have_content("Please log in.")
    expect(page).to have_current_path(login_path)

    # nested path
    page.driver.submit :delete, house_note_path(house, kitchen), {}
    expect(page).to have_content("Please log in.")
    expect(page).to have_current_path(login_path)
  end
end


feature "Correct user must be signed in to assess notes" do

  scenario "signed in user tries to view another user's note" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    house = House.create!(user: user,
                              name: "Near Work",
                              street: "101 Arch Street",
                              city: "Boston",
                              state: "MA",
                              zip_code: "02110")

    kitchen = Note.create!(house: house,
                              user: user,
                              room: "Kitchen",
                              rating: -1,
                              pros: "lots of cabinet space and good flow into sun room",
                              cons: "gallery style - too small")

    wrong_user = User.create!(email: "joe_schmoe@email.com",
                          password: "supersecret007",
                          password_confirmation: "supersecret007",
                          first_name: "Joe",
                          last_name: "Schmoe")

    visit root_path
    click_link('Log In', match: :first)
    fill_in "Email",    with: "joe_schmoe@email.com"
    fill_in "Password", with: "supersecret007"
    click_button "Log In"

    # Shallow route
    visit note_path(kitchen)
    expect(page).to have_content("Unauthorized access.")
    expect(page).to have_current_path(user_path(wrong_user))

    # Nested route
    visit house_note_path(house, kitchen)
    expect(page).to have_content("Unauthorized access.")
    expect(page).to have_current_path(user_path(wrong_user))
  end

  scenario "signed in user tries to edit another user's note" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    house = House.create!(user: user,
                              name: "Near Work",
                              street: "101 Arch Street",
                              city: "Boston",
                              state: "MA",
                              zip_code: "02110")

    kitchen = Note.create!(house: house,
                              user: user,
                              room: "Kitchen",
                              rating: -1,
                              pros: "lots of cabinet space and good flow into sun room",
                              cons: "gallery style - too small")

    wrong_user = User.create!(email: "joe_schmoe@email.com",
                        password: "supersecret007",
                        password_confirmation: "supersecret007",
                        first_name: "Joe",
                        last_name: "Schmoe")

    visit root_path
    click_link('Log In', match: :first)
    fill_in "Email",    with: "joe_schmoe@email.com"
    fill_in "Password", with: "supersecret007"
    click_button "Log In"

    # Shallow route
    visit edit_note_path(kitchen)
    expect(page).to have_content("Unauthorized access.")
    expect(page).to have_current_path(user_path(wrong_user))

    # Nested route
    visit edit_house_note_path(house, kitchen)
    expect(page).to have_content("Unauthorized access.")
    expect(page).to have_current_path(user_path(wrong_user))
  end

  scenario "signed in user tries to update another user's note" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    house = House.create!(user: user,
                              name: "Near Work",
                              street: "101 Arch Street",
                              city: "Boston",
                              state: "MA",
                              zip_code: "02110")

    kitchen = Note.create!(house: house,
                              user: user,
                              room: "Kitchen",
                              rating: -1,
                              pros: "lots of cabinet space and good flow into sun room",
                              cons: "gallery style - too small")

    wrong_user = User.create!(email: "joe_schmoe@email.com",
                        password: "supersecret007",
                        password_confirmation: "supersecret007",
                        first_name: "Joe",
                        last_name: "Schmoe")

    visit root_path
    click_link('Log In', match: :first)
    fill_in "Email",    with: "joe_schmoe@email.com"
    fill_in "Password", with: "supersecret007"
    click_button "Log In"

    # Shallow route
    page.driver.submit :patch, note_path(kitchen), {}
    expect(page).to have_content("Unauthorized access.")
    expect(page).to have_current_path(user_path(wrong_user))

    # Nested route
    page.driver.submit :patch, house_note_path(house, kitchen), {}
    expect(page).to have_content("Unauthorized access.")
    expect(page).to have_current_path(user_path(wrong_user))
  end

  scenario "signed in user tries to destroy another user's note" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    house = House.create!(user: user,
                              name: "Near Work",
                              street: "101 Arch Street",
                              city: "Boston",
                              state: "MA",
                              zip_code: "02110")

    kitchen = Note.create!(house: house,
                              user: user,
                              room: "Kitchen",
                              rating: -1,
                              pros: "lots of cabinet space and good flow into sun room",
                              cons: "gallery style - too small")

    wrong_user = User.create!(email: "joe_schmoe@email.com",
                        password: "supersecret007",
                        password_confirmation: "supersecret007",
                        first_name: "Joe",
                        last_name: "Schmoe")

    visit root_path
    click_link('Log In', match: :first)
    fill_in "Email",    with: "joe_schmoe@email.com"
    fill_in "Password", with: "supersecret007"
    click_button "Log In"

    # Shallow route
    page.driver.submit :delete, note_path(kitchen), {}
    expect(page).to have_content("Unauthorized access.")
    expect(page).to have_current_path(user_path(wrong_user))

    # Nested route
    page.driver.submit :delete, house_note_path(house, kitchen), {}
    expect(page).to have_content("Unauthorized access.")
    expect(page).to have_current_path(user_path(wrong_user))
  end
end
