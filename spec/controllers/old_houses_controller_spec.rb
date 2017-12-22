require 'rails_helper'

feature "User must be signed in to assess house pages" do

  scenario "unauthenticated user tries to access house show page" do
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

    # shallow path
    visit house_path(house)
    expect(page).to have_content("Please log in.")
    expect(page).to have_current_path(login_path)

    # nested path
    visit user_house_path(user_id: user.id, id: house.id)
    expect(page).to have_content("Please log in.")
    expect(page).to have_current_path(login_path)
  end

  scenario "unauthenticated user tries to access house edit page" do
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

    # nested path
    visit edit_user_house_path(user, house)
    expect(page).to have_content("Please log in.")
    expect(page).to have_current_path(login_path)
  end

  scenario "unauthenticated user tries to access house update page" do
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

    # nested path
    page.driver.submit :patch, user_house_path(user, house), {}
    expect(page).to have_content("Please log in.")
    expect(page).to have_current_path(login_path)
  end

  scenario "unauthenticated user tries to access house destroy page" do
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

    # nested path
    page.driver.submit :delete, user_house_path(user, house), {}
    expect(page).to have_content("Please log in.")
    expect(page).to have_current_path(login_path)
  end

end

feature "Correct user must be signed in to assess house pages" do

  scenario "signed in user tries to view another user's house" do
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
    visit house_path(house)
    expect(page).to have_content("Unauthorized access.")
    expect(page).to have_current_path(root_path)

    # Nested route
    visit user_house_path(user_id: user.id, id: house.id)
    expect(page).to have_content("Unauthorized access.")
    expect(page).to have_current_path(root_path)
  end

  scenario "signed in user tries to edit another user's house" do
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

    # Nested route
    visit edit_user_house_path(user, house)
    expect(page).to have_content("Unauthorized access.")
    expect(page).to have_current_path(root_path)
  end

  scenario "signed in user tries to update another user's house" do
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

    # Nested route
    page.driver.submit :patch, user_house_path(user, house), {}
    expect(page).to have_content("Unauthorized access.")
    expect(page).to have_current_path(root_path)
  end

  scenario "signed in user tries to destroy another user's house" do
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

    # Nested route
    page.driver.submit :delete, user_house_path(user, house), {}
    expect(page).to have_content("Unauthorized access.")
    expect(page).to have_current_path(root_path)
  end

end
