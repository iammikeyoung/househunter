require 'rails_helper'

feature "authorized user edits and deletes houses in their list" do

  scenario "user can edit a house's info" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    house = House.create!(user: user,
                          name: "Above Italian Place",
                          street: "307 Hanover Street",
                          city: "Boston",
                          state: "MA",
                          zip_code: "02113")

    visit root_path
    click_link 'Log In'
    fill_in "Email",    with: "archer@example.gov"
    fill_in "Password", with: "sploosh1"
    click_button "Log In"
    click_link 'Above Italian Place'

    expect(page).to have_content("Edit House Form")
    fill_in "Name", with: "In North End"
    click_button "Update"

    expect(page).to have_content("House successfully updated")
    expect(page).to have_link("In North End")
  end

  scenario "user can delete a house from their list" do
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

    house_two = House.create!(user: user,
                              name: "Above Italian Place",
                              street: "307 Hanover Street",
                              city: "Boston",
                              state: "MA",
                              zip_code: "02113")

    visit root_path
    click_link 'Log In'
    fill_in "Email",    with: "archer@example.gov"
    fill_in "Password", with: "sploosh1"
    click_button "Log In"
    click_link 'Above Italian Place'
    click_link 'Delete'

    expect(page).to have_link("Near Work")
    expect(page).to_not have_link("Above Italian Place")
  end
end
