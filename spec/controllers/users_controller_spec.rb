require 'rails_helper'

feature "User must be signed in to assess user pages" do

  scenario "unauthenticated user tries to access user show page" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")
    wrong_user = User.create!(email: "joe_schmoe@email.com",
                        password: "supersecret007",
                        password_confirmation: "supersecret007",
                        first_name: "Joe",
                        last_name: "Schmoe")

    visit user_path(user)
    expect(page).to have_content("Please log in.")
    expect(page).to have_current_path(login_path)
  end

  scenario "unauthenticated user tries to access user edit page" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    visit edit_user_path(user)
    expect(page).to have_content("Please log in.")
    expect(page).to have_current_path(login_path)
  end

  scenario "unauthenticated user tries to access user update page" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    page.driver.submit :patch, user_path(user), {}
    expect(page).to have_content("Please log in.")
    expect(page).to have_current_path(login_path)
  end

  scenario "unauthenticated user tries to access user destroy page" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    page.driver.submit :delete, user_path(user), {}
    expect(page).to have_content("Please log in.")
    expect(page).to have_current_path(login_path)
  end
end

feature "Correct user must be signed in to assess user pages" do

  scenario "signed in user tries to access another user show page"do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")
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

    visit user_path(user)
    expect(page).to have_content("Unauthorized access.")
    expect(page).to have_current_path(root_path)
  end

  scenario "signed in user tries to access another user edit page" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")
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

    visit edit_user_path(user)
    expect(page).to have_content("Unauthorized access.")
    expect(page).to have_current_path(root_path)
  end

  scenario "signed in user tries to access another user update page" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")
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

    page.driver.submit :patch, user_path(user), {}
    expect(page).to have_content("Unauthorized access.")
    expect(page).to have_current_path(root_path)
  end

  scenario "signed in user tries to access another user delete page" do
    user = User.create!(email: "archer@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")
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

    page.driver.submit :delete, user_path(user), {}
    expect(page).to have_content("Unauthorized access.")
    expect(page).to have_current_path(root_path)
  end
end
