require 'rails_helper'

feature "authorized user sees their list of houses" do



  scenario "user sees list of houses and link for adding new house to list" do
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

    expect(page).to have_content("Near Work")
    expect(page).to have_content("101 Arch Street Boston MA 02110")
    expect(page).to have_content("Above Italian Place")
    expect(page).to have_content("307 Hanover Street Boston MA 02113")
    expect(page).to have_link("Add New House")
  end

  scenario "user clicks link and is taken to show page for given house" do

    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    house_three = House.create!(user: user,
                              name: "Near Work",
                              street: "101 Arch Street",
                              city: "Boston",
                              state: "MA",
                              zip_code: "02110",
                              asking_amount: 250_000,
                              total_sqft: 1600)

    house_four = House.create!(user: user,
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
    click_link 'Near Work'

    expect(page).to have_content("Near Work")
    expect(page).to have_content("Asking Amount: $250000")
    expect(page).to have_content("Total Sqft: 1600")

    click_link "Back"
    expect(page).to have_content("User's Homepage")
    expect(page).to_not have_content("House Show Page")
  end
end
